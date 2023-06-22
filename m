Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6E73A8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjFVTUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:19:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBFABA;
        Thu, 22 Jun 2023 12:19:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B210E320092A;
        Thu, 22 Jun 2023 15:19:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 15:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687461596; x=1687547996; bh=6+6r2jl0FgLMZhz62vz2TuajhsbnfKNl/0S
        YnIJgOYk=; b=cKc5M8i/kxkAd48cHUJPl/dMTVQeBtrTTPo3fcmtqYcNAoVtikC
        L66GZDOJ8ySjYAko8YPGVGDBaLQGFW8fxIgAgIyQ+AQIBfItHSJ6xo6DZQUNCemk
        4lirbqL5J/JiPmYEO8u6X3YAaU6/LHgkPub3hwi2Kz3+n7ZY8BSqyEI29V0tA6KR
        T0UDAdYPNyQXjvd/CoXvhAG2kNTZEME+ZW4MwxkmQytphbPk++lh8pdyPBYx/Zhk
        IOo71hSiLDCss0wuHwI2T00VBPgKycmlTkR7u+IAE2Qj9DXqv7xRt6d2jfOv+3L8
        Z/mi4gfNXHHkC4vl7Vo/JGbGo/fGMGoCvOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687461596; x=1687547996; bh=6+6r2jl0FgLMZ
        hz62vz2TuajhsbnfKNl/0SYnIJgOYk=; b=bdSACyKrfoSxEzz3j8tmMKJgKOTjs
        d1v5Y9JB8u4kRSXpc+LyIY88+HFfrr2YQ1yJ/6kUylSzPdA05Ist8JhhEa9QzKKE
        ytiJGk7wJBOmgDGlcnOJYy/onAbwc0Rr+bGTrHqKR0pcfPOWuOMuuJlo0e/y4GrR
        BcGQDp7ykjbhjB2ZtXERGpIOAEaCjmMVymHLDjzjK+pS+luFViTdK1Glm2ANHtCe
        8yhsepfIkjP06N5dMO4sDHYgAfnrFZGoF0TYksDKKHtwX+bpDVU4dxP/WvDYP9zQ
        niufq1rHAQG8mM6XcjRkI/DYBEf6MYQy7jvGjV/MIZnWTPvflm7chy71A==
X-ME-Sender: <xms:256UZNJgPtwKwtJFe8ePUMOdcV00ejlEdbW6WbcbC21IJVr411xY4Q>
    <xme:256UZJIBGnfSmui_3XbELMffei0asPNlRkjnpLIKbj1swFcCb-LWnN5c9rxZ_BwEX
    JcvXAaZL_iyj3Z4b5M>
X-ME-Received: <xmr:256UZFsvdBl-9fDTBU6BQurzYksmq_hnbxH0oceDiVyxtsFHPJSOdfEmLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepvdekleffgfetfeeijedtieehtdeuhfegueejkeevueeileff
    gfduleffjeffuddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:256UZOZXyw9mfSAiTP-_NotkHTTvaS-n4CJWRxrLzXgJXMvd6Npl7g>
    <xmx:256UZEbV2CJ1fEu1aKGeglboa7DlB4SgiC-zHd39mwspV8wx-GEM4A>
    <xmx:256UZCBPXneMptxjUXeHbPGqXg4lDvpql72i5rztHLo2SRP7eZxZ5Q>
    <xmx:3J6UZJOeLbPLbL1w77Sem6cLk8cFggj5w8HpjdHqK_GsAI5BFUNUvg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 15:19:54 -0400 (EDT)
Date:   Thu, 22 Jun 2023 12:19:53 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: builddeb: always make modules_install, to install
 modules.builtin*
Message-ID: <f7e9220aad3d98bd174f7dcbd68031e1e15ea968.1687461492.git.josh@joshtriplett.org>
References: <20230615111743.883891-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615111743.883891-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even for a non-modular kernel, the kernel builds modules.builtin and
modules.builtin.modinfo, with information about the built-in modules.
Tools such as initramfs-tools need these files to build a working
initramfs on some systems, such as those requiring firmware.

Now that `make modules_install` works even in non-modular kernels and
installs these files, unconditionally invoke it when building a Debian
package.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

This patch depends on
https://lore.kernel.org/lkml/20230615111743.883891-1-masahiroy@kernel.org/

 scripts/package/builddeb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 252faaa5561c..f500e3910158 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -62,8 +62,8 @@ install_linux_image () {
 		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH="${pdir}/usr/lib/linux-image-${KERNELRELEASE}" dtbs_install
 	fi
 
+	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
 	if is_enabled CONFIG_MODULES; then
-		${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
 		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
 		rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
 		if [ "${SRCARCH}" = um ] ; then
-- 
2.40.1

