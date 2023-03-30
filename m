Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6D6CF952
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjC3Cz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3Cz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:55:56 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FC355A1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:55:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Veyr5Lz_1680144950;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Veyr5Lz_1680144950)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 10:55:50 +0800
Date:   Thu, 30 Mar 2023 10:55:51 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
        kirill.shutemov@linux.intel.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Message-ID: <20230330025550.GA2522@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <17b65c2a-69a8-6348-da64-641d34be122e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b65c2a-69a8-6348-da64-641d34be122e@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 08:49:24AM -0500, Tom Lendacky wrote:
> On 3/28/23 21:59, Wu Zongyong wrote:
> > It seems MOVSXD which opcode is 0x63 is not handled, support
> > to decode it in insn_decode_mmio().
> 
> Aren't there some caveats to worry about with this instruction based on the
> presence of the REX prefix 64-bit operand size bit? Sometimes it can be a
> sign extended and sometimes it can be a zero extended.

If I undertand right, the patch should like that?

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 558a605929db..a1272f1be35d 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1607,6 +1607,13 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
                return INSN_MMIO_DECODE_FAILED;

        switch (insn->opcode.bytes[0]) {
+       case 0x63:
+               *bytes = 4;
+               if (X86_REX_W(insn->rex_prefix.value))
+                       type = INSN_MMIO_READ_SIGN_EXTEND;
+               else
+                       type = INSN_MMIO_READ_ZERO_EXTEND;
+               break;
        case 0x88: /* MOV m8,r8 */
                *bytes = 1;
                fallthrough;
> 
> Thanks,
> Tom
> 
> > 
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > ---
> >   arch/x86/lib/insn-eval.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> > index 558a605929db..db6f93bad219 100644
> > --- a/arch/x86/lib/insn-eval.c
> > +++ b/arch/x86/lib/insn-eval.c
> > @@ -1607,6 +1607,10 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
> >   		return INSN_MMIO_DECODE_FAILED;
> >   	switch (insn->opcode.bytes[0]) {
> > +	case 0x63: /* MOVSXD r64, m32 */
> > +		*bytes = 4;
> > +		type = INSN_MMIO_READ_SIGN_EXTEND;
> > +		break;
> >   	case 0x88: /* MOV m8,r8 */
> >   		*bytes = 1;
> >   		fallthrough;
