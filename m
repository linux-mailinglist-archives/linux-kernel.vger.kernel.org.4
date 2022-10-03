Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBED5F278A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 03:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJCBqq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 21:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 21:46:43 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA127CC4;
        Sun,  2 Oct 2022 18:46:41 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 71710C0802;
        Mon,  3 Oct 2022 01:46:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id A5C348000E;
        Mon,  3 Oct 2022 01:46:31 +0000 (UTC)
Message-ID: <c7e45416cc911290efb5ad669f4a45bdc5678f69.camel@perches.com>
Subject: new checkpatch flexible array test ?  (was Re: [PATCH v4 12/14]
 gunyah: rsc_mgr: Add RPC for console services)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Oct 2022 18:46:30 -0700
In-Reply-To: <YzbfaCj9jvSUDfUg@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
         <20220928195633.2348848-13-quic_eberman@quicinc.com>
         <YzbfaCj9jvSUDfUg@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: s8bxywehf4i6ap8qz4d4zh7cgy8f5nng
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A5C348000E
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+OfeghBDJYxV12c+mletSZVAMPeQeBrtw=
X-HE-Tag: 1664761591-583478
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-30 at 14:22 +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 28, 2022 at 12:56:31PM -0700, Elliot Berman wrote:
> > Gunyah resource manager defines a simple API for virtual machine log
> > sharing with the console service.
[]
> > diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
[]
> > +struct gh_rm_notif_vm_console_chars {
> > +	u16 vmid;
> > +	u16 num_bytes;
> > +	u8 bytes[0];
> 
> Please do not use [0] for new structures, otherwise we will just have to
> fix them up again as we are trying to get rid of all of these from the
> kernel. Just use "bytes[];" instead.

Maybe a checkpatch addition like:
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2737e4ced5745..187ed84c1f80a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3948,6 +3948,17 @@ sub process {
 			}
 		}
 
+# check for zero length array declarations in likely structs
+		if ($line =~ /^\+\t($Declare\s*$Ident)\s*\[\s*0\s*\]\s*;\s*$/ &&
+		    defined $lines[$linenr] &&
+		    $lines[$linenr] =~ /^[\+ ]\}\s*(?:__\w+\s*(?:$balanced_parens)?)\s*;\s*$/) {
+			if (WARN("FLEXIBLE_ARRAY_ZERO",
+				 "Prefer flexible length array declarations with [] over [0]\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\[\s*0\s*\]/[]/;
+			}
+		}
+
 # check for multiple consecutive blank lines
 		if ($prevline =~ /^[\+ ]\s*$/ &&
 		    $line =~ /^\+\s*$/ &&
