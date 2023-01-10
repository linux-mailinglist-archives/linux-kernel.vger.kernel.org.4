Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C964664390
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjAJOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbjAJOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:47:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E059305;
        Tue, 10 Jan 2023 06:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EFB0B81686;
        Tue, 10 Jan 2023 14:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7740FC433D2;
        Tue, 10 Jan 2023 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362007;
        bh=IaikD1RTYaN6M6TGo0lVcnpxh3sUPsTrkuA870j4PL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kPjEfiMiNWq5fLNk+oll30rgxZfthMc/ps5etPKXrknVOEBg6gzwdvidY8MKBKYP8
         Udr030lMLCJpbUF2WteuSGJlVyArnUdZ4rkgZH+uevM6f6iSUbJNpb1CAXEvRiIAt9
         1WBMUSqNgJM8kCfDif+8D2JUvQiBeLDHeRb79FAxTrM/gyQ1XwO46j95ODpxOyw/G+
         pqjXPisHqhUa/O7joUHKuQLYUmSKMy0Z50Y3BHpHemxi/bTxNo8PGJd/NNj68oIMfO
         SXxbSiMIM9PnRKaBpWHOnHlKbvp1htTr6dcR3g+OJex6hnwET3daPaLXZ6dBXMcc+4
         JVreBycgW9dGw==
Date:   Tue, 10 Jan 2023 23:46:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Message-Id: <20230110234643.7bbd340ece99c28f25fe7ad7@kernel.org>
In-Reply-To: <e2ac0fa4-28f0-f4d8-e02a-b2a5d6131a48@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
        <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
        <20230110001820.5ca81344286f614ed4ccec77@kernel.org>
        <e2ac0fa4-28f0-f4d8-e02a-b2a5d6131a48@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 17:26:07 +0530
Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:

> 
> 
> On 1/9/2023 8:48 PM, Masami Hiramatsu (Google) wrote:
> > On Mon, 9 Jan 2023 20:01:05 +0530
> > Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
> > 
> >> Increasing the memory size of bootconfig to be able to handle a max number of
> >> 8192 nodes to be fitted in memory size of 256KB.
> > 
> > Sorry, but you missed the 'xbc_node::data' stores the index of the data and
> > that is uint16_t. So the XBC_DATA_MAX is fixed limitation.
> > 
> > The number of nodes (XBC_NODE_MAX) can be expanded because I just decided it
> > to keep the pre-compiled array size ~8KB. Maybe expanding it to 64KB just
> > increase the size of kernel on init memory (and freed after boot).
> > 
> > Could you tell me why you need such a big data for your DCC?
> > 
> > Thank you,
> 
> DCC is a debugging tool used in qcom which is needed to debug crashes
> that can happen at boot-time. For debugging purposes a large number of
> registers need to be configured in DCC driver which is to be fed via the
> bootconfig file. For that we need to expand the nodes as well as memory
> for using bootconfig.

Hmm, how many registers does DCC usually use? And how big the bootconfig
file is usually? I have no idea about that.

> Can you let us know the changes that you suggest for doing the same? Is 
> it fine to just increase the XBC_NODE_MAX, do we also need to
> change the uint16_t to u32 for proper storing of index values?

Expanding the number of max nodes is easy, just increase the XBC_NODE_MAX
(must be less than 64k). That will also increase the memory consumption
during the boot time even if the bootconfig is small. Anyway, it will be
freed after boot, so it maybe OK.

But expanding the size of max bootconfig needs to change the type of
the 'data' field to uint32_t (since that will be used for building 
bootconfig tool) and you also must confirm that `tools/bootconfig/bootconfig`
can be built and pass the test-bootconfig.sh.
Hmm, comparing with expanding the max number of XBC node, changing the
'data' type to uint32_t may not have much impact on memory consumption point
of view, because it may increase only 20% of memory, but expanding the
MAX_XBC_NODE always increases more than double.

Thus, if we can accept increasing the number of node, it should be OK to
change the 'data' type.

BTW, I think now we don't need the ' __attribute__ ((__packed__))' for
struct xbc_node. It was packed for reducing the size of array and able to
pass 'compiled' bootconfig, but now it is just passed as a text data for
safety.

Thank you,

> 
> 
> > 
> >>
> >> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> >> ---
> >>   include/linux/bootconfig.h | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> >> index 1611f9d..64d233b 100644
> >> --- a/include/linux/bootconfig.h
> >> +++ b/include/linux/bootconfig.h
> >> @@ -55,11 +55,11 @@ struct xbc_node {
> >>   } __attribute__ ((__packed__));
> >>   
> >>   #define XBC_KEY		0
> >> -#define XBC_VALUE	(1 << 15)
> >> -/* Maximum size of boot config is 32KB - 1 */
> >> +#define XBC_VALUE	(1 << 18)
> >> +/* Maximum size of boot config is 256KB - 1 */
> >>   #define XBC_DATA_MAX	(XBC_VALUE - 1)
> >>   
> >> -#define XBC_NODE_MAX	1024
> >> +#define XBC_NODE_MAX	8192
> >>   #define XBC_KEYLEN_MAX	256
> >>   #define XBC_DEPTH_MAX	16
> >>   
> >> -- 
> >> 2.7.4
> >>
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
