Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB56F77C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEDVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjEDVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:07:15 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181893FE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:07:14 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id A34C640755D7;
        Thu,  4 May 2023 20:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A34C640755D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1683232198;
        bh=kDImfhQO/qI/3ff441daw4emlLBdlJ25y15oGU/S5Rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+RFPFYosHbunosEgZSAtO4gQnjK8cOTlpUe/5ro/wgIOBQ0VYifbz8821Aydfznj
         KJVFZq7mNQz4m0fkikY83Ghvyw+gCRD96lmI4GP9XTdkH7kJp50lTO5Y6b8tLp9P0J
         mz8PN9GDgATrUsp63aoHEwnlf/KC8F+fXr4Ibr14=
MIME-Version: 1.0
Date:   Thu, 04 May 2023 23:29:58 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Subject: Re: [PATCH 4/4] kselftest: vm: Add tests for no-inherit
 memory-deny-write-execute
In-Reply-To: <20230504170942.822147-5-revest@chromium.org>
References: <20230504170942.822147-1-revest@chromium.org>
 <20230504170942.822147-5-revest@chromium.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <66900d0ad42797a55259061f757beece@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 20:09, Florent Revest wrote:
> Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> PR_SET_MDWE prctl.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/testing/selftests/mm/mdwe_test.c | 95 ++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c
> b/tools/testing/selftests/mm/mdwe_test.c
> index 91aa9c3099e7..9f08ed1b99ae 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -22,6 +22,8 @@
> 
>  TEST(prctl_flags)
>  {
> +	EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
> +

PR_MDWE_NO_INHERIT is defined to an int constant, so passing it to 
prctl() without a cast to long or similar may produce wrong code on 
64-bit targets (ABIs typically don't require the compiler to clear the 
upper 32 bits of a 64-bit register when passing a 32-bit argument, so 
va_arg(arg, unsigned long) in prctl() implementation might get junk).

Arguably, defining PR_MDWE_* to plain int constants is a bug, or at 
least a footgun for users of uapi headers.

Thanks,
Alexey

>  	EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
>  	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
>  	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
> @@ -33,6 +35,66 @@ TEST(prctl_flags)
>  	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
>  }
> 
> +FIXTURE(consecutive_prctl_flags) {};
> +FIXTURE_SETUP(consecutive_prctl_flags) {}
> +FIXTURE_TEARDOWN(consecutive_prctl_flags) {}
> +
> +FIXTURE_VARIANT(consecutive_prctl_flags)
> +{
> +	unsigned long first_flags;
> +	unsigned long second_flags;
> +	bool should_work;
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, same)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.should_work = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.second_flags = 0,
> +	.should_work = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, 
> cant_disable_mdwe_no_inherit)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> +	.second_flags = 0,
> +	.should_work = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, can_lower_privileges)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> +	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.should_work = true,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_gain_privileges)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> +	.should_work = false,
> +};
> +
> +TEST_F(consecutive_prctl_flags, two_prctls)
> +{
> +	int ret;
> +
> +	EXPECT_EQ(prctl(PR_SET_MDWE, variant->first_flags, 0L, 0L, 0L), 0);
> +
> +	ret = prctl(PR_SET_MDWE, variant->second_flags, 0L, 0L, 0L);
> +	if (variant->should_work) {
> +		EXPECT_EQ(ret, 0);
> +	} else {
> +		EXPECT_NE(ret, 0);
> +	}
> +}
> +
>  FIXTURE(mdwe)
>  {
>  	void *p;
> @@ -45,28 +107,45 @@ FIXTURE_VARIANT(mdwe)
>  {
>  	bool enabled;
>  	bool forked;
> +	bool inherit;
>  };
> 
>  FIXTURE_VARIANT_ADD(mdwe, stock)
>  {
>  	.enabled = false,
>  	.forked = false,
> +	.inherit = false,
>  };
> 
>  FIXTURE_VARIANT_ADD(mdwe, enabled)
>  {
>  	.enabled = true,
>  	.forked = false,
> +	.inherit = true,
>  };
> 
> -FIXTURE_VARIANT_ADD(mdwe, forked)
> +FIXTURE_VARIANT_ADD(mdwe, inherited)
>  {
>  	.enabled = true,
>  	.forked = true,
> +	.inherit = true,
>  };
> 
> +FIXTURE_VARIANT_ADD(mdwe, not_inherited)
> +{
> +	.enabled = true,
> +	.forked = true,
> +	.inherit = false,
> +};
> +
> +static bool executable_map_should_fail(const FIXTURE_VARIANT(mdwe) 
> *variant)
> +{
> +	return variant->enabled && (!variant->forked || variant->inherit);
> +}
> +
>  FIXTURE_SETUP(mdwe)
>  {
> +	unsigned long mdwe_flags;
>  	int ret, status;
> 
>  	self->p = NULL;
> @@ -76,13 +155,17 @@ FIXTURE_SETUP(mdwe)
>  	if (!variant->enabled)
>  		return;
> 
> -	ret = prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
> +	mdwe_flags = PR_MDWE_REFUSE_EXEC_GAIN;
> +	if (!variant->inherit)
> +		mdwe_flags |= PR_MDWE_NO_INHERIT;
> +
> +	ret = prctl(PR_SET_MDWE, mdwe_flags, 0L, 0L, 0L);
>  	ASSERT_EQ(ret, 0) {
>  		TH_LOG("PR_SET_MDWE failed or unsupported");
>  	}
> 
>  	ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> -	ASSERT_EQ(ret, 1);
> +	ASSERT_EQ(ret, mdwe_flags);
> 
>  	if (variant->forked) {
>  		self->pid = fork();
> @@ -113,7 +196,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
>  TEST_F(mdwe, mmap_WRITE_EXEC)
>  {
>  	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 
> 0, 0);
> -	if (variant->enabled) {
> +	if (executable_map_should_fail(variant)) {
>  		EXPECT_EQ(self->p, MAP_FAILED);
>  	} else {
>  		EXPECT_NE(self->p, MAP_FAILED);
> @@ -139,7 +222,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
>  	ASSERT_NE(self->p, MAP_FAILED);
> 
>  	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
> -	if (variant->enabled) {
> +	if (executable_map_should_fail(variant)) {
>  		EXPECT_LT(ret, 0);
>  	} else {
>  		EXPECT_EQ(ret, 0);
> @@ -154,7 +237,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
>  	ASSERT_NE(self->p, MAP_FAILED);
> 
>  	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
> -	if (variant->enabled) {
> +	if (executable_map_should_fail(variant)) {
>  		EXPECT_LT(ret, 0);
>  	} else {
>  		EXPECT_EQ(ret, 0);
