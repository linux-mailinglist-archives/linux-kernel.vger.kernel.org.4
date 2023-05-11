Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63CD6FF71D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbjEKQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjEKQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4866FF1;
        Thu, 11 May 2023 09:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6BB61A85;
        Thu, 11 May 2023 16:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09390C433D2;
        Thu, 11 May 2023 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683822322;
        bh=O0ddsVjQX2XqLZGXzSarzIeiDR/AJKke8DZiiaGgiso=;
        h=From:To:Cc:Subject:Date:From;
        b=Vr38RPBFMq334MQhYb6E7bf93P39D7Tk5w0Qn8WmkdlCKfe5TW0cqr1Ou3feEJUQP
         nrwe1amGLeGDVfpE0MFZaZbzmmsQu6Eyl59KTPbN1D3E3ZteDDmwTsGGG9+BvQn9I9
         tCRj3h8NhV3BDlIxrA0/2TRL/s+g0cg1WF9FMxEKTKP46Crt26T/PSuEAgF3dGjhTd
         1zGv/YN5wzi9EGf/xohpX53ZTXhdJ5tLILUcXqYv9cvPu52zGyyi1Al2pjl9AHXiLW
         hBg0g3SqLUTl2a9UPgF6CETox1momsItbjb9fxEvi6GHJZJWIUn15lVqlMISWM9i6L
         n+HwaeHTMjhNw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] modpost: error out if addend_*_rel() is not implemented for REL arch
Date:   Fri, 12 May 2023 01:24:22 +0900
Message-Id: <20230511162423.1922133-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section mismatch check relies on the relocation entries.

For REL, the addend value is implicit, so we need some code to compute
it. Currently, EM_386, EM_ARM, and EM_MIPS are supported. This commit
makes sure we covered all the cases.

I believe the other architectures use RELA, where the explicit r_addend
field exists.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 95da374cc534..44309d463a49 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1442,6 +1442,8 @@ static void section_rel(const char *modname, struct elf_info *elf,
 			if (addend_mips_rel(elf, sechdr, &r))
 				continue;
 			break;
+		default:
+			fatal("Please add code to calculate addend for this architecture\n");
 		}
 		sym = elf->symtab_start + r_sym;
 		/* Skip special sections */
-- 
2.39.2

