Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69038715C32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjE3KsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjE3Krn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:47:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD45FE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:47:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVpxl6C6cz4x1R;
        Tue, 30 May 2023 20:47:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685443644;
        bh=G20+Sdm/98wI46f2WRdfsERiE5mRdZTpwi6+jvG8R1U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d+o7t46BGfbpB2ob36lRdXwMjgQzcU5NBOtF/Kj7UJztuuPyk2IJwa73ehmTZJQZo
         lvophwgIwGtC8ggYJcCw84/aiAJxtLUARSGeIkR/a/WeQWaJf4d5aL3btthULw/ymK
         dUN3IYKTAdv1A9ZqJmKYbWoAUGf68BGtcBZmWCXtuZkI3i1CwSoWzqGU66PE9lgAtg
         o0TyPjR/HLQXmG6vR4z6WibmSmBFnhzNC+sbSnk3pP8LwhuOSdCI4I/trcM/k8aBRr
         dkab/MWQeszlLgVUVkCgRfpuf4j5ULMqcer+eONXtqEJqnh3qwntA9qAq2Tv7NJxnX
         sKg7GkCAT7jfQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>, mirimmad@outlook.com
Cc:     Immad Mir <mirimmad17@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix debugfs_create_dir error checking
In-Reply-To: <2023052835-oxidant-doily-404f@gregkh>
References: <CY5PR12MB64553EE96EBB3927311DB598C6459@CY5PR12MB6455.namprd12.prod.outlook.com>
 <2023052835-oxidant-doily-404f@gregkh>
Date:   Tue, 30 May 2023 20:47:21 +1000
Message-ID: <87zg5mrt8m.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Sun, May 28, 2023 at 01:16:44PM +0530, mirimmad@outlook.com wrote:
>> From: Immad Mir <mirimmad17@gmail.com>
>> 
>> The debugfs_create_dir returns ERR_PTR incase of an error and the
>> correct way of checking it by using the IS_ERR inline function, and
>> not the simple null comparision. This patch fixes this.
>> 
>> Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
>> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
>> ---
>>  arch/powerpc/platforms/powernv/opal-xscom.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
>> index 6b4eed2ef..262cd6fac 100644
>> --- a/arch/powerpc/platforms/powernv/opal-xscom.c
>> +++ b/arch/powerpc/platforms/powernv/opal-xscom.c
>> @@ -168,7 +168,7 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
>>  	ent->path.size = strlen((char *)ent->path.data);
>> 
>>  	dir = debugfs_create_dir(ent->name, root);
>> -	if (!dir) {
>> +	if (IS_ERR(dir)) {
>>  		kfree(ent->path.data);
>>  		kfree(ent);
>>  		return -1;
>
> Why is this driver caring if debugfs is working or not at all?  It
> should just ignore the error and keep moving forward.

It's creating directories and then creating files in those directories.
So I think it makes sense that it checks that the directory was created
successfully. It doesn't check whether the files were created.

> And -1 is not a valid error number :(

It's EPERM :) - but yeah probably not really the right error in this
case.

Still I think this patch is an improvement so I'll plan to merge it.

cheers
