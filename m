Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8F5F8875
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJHXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHXRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 19:17:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD5B17A8F;
        Sat,  8 Oct 2022 16:17:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so7508633pls.4;
        Sat, 08 Oct 2022 16:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lULkEACMGXAqLMVro1NAmGHqDFrc11oNE+hqnHHNv9k=;
        b=Of0rgZhZNm/DOfl8gCGmaW0Z9i/p50pUPg86vCNuYcDOiRzCHe4hsqzkPU04pVf/tm
         n2E2j835OaHbUT7Z6HqWoUskm4hv4g+mi8UWz2G18AG9103fXphC7VJuHoBLwMMZfdON
         2ssEr5cIGmU9k0lwvN1jiTWb7rdOi4bgb17N9ZmMxE/F4FtGNw7uKn0px9aXx5PNCM22
         Xjyb64G2cjZF+UsnyJ91CDYI3OaoahaMyo91TMmSsckTLM2+o8w9UBHWGB7iWVQVynKm
         A+LAS4oUZ7mbibX+JjDc+DIJbXAucgnPidb9eZcjGNKraUkJ+v7WvFFMWDPMeBsgM7od
         cKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lULkEACMGXAqLMVro1NAmGHqDFrc11oNE+hqnHHNv9k=;
        b=rz/7m52M+ru2JL4VKSprYYX3p8/REs1MjgkosXGl5UWwFgoRrG2BTuMz9TafLnwjvm
         fGdTPuAt/+q8cAHSr7pJm/72cs9d+BbqRhWR7TsB3pvv+kok025kR+Iun+FC4nuPnSuP
         6gkYBtmA//a9ld63DhTDs3WUGY9r4PDBRqgjMcnmKaGtySCeVsRg2k6chV13uAS2FN0i
         Q2fm9YiR69zQhbt+xR+Aa4/YwAAntvw3HHNbYZtG0N50l15wz+rdtpVz58lgsMhSFth8
         INnfz1ZAKZAGmHFMnoQCk+aoMTvZlkeoR5jI77JW+TPf9SKt9UlI+MNs0NUBKT9T0nSD
         dziw==
X-Gm-Message-State: ACrzQf0dcx0oHMFHeXVMkC17Kfg69b4/79gNRNGlzRNe7hgJ0BonnZX3
        d/jv5vRR1A3R8h/eDuEmz7w=
X-Google-Smtp-Source: AMsMyM4xCPYXMXi1Te7y4oshOQYKBRSbFnKh+S3fc5qSiQRjfgq0SfUO8kmr+SCApTGZiY4s8dHRlA==
X-Received: by 2002:a17:902:bc8c:b0:178:a406:72ea with SMTP id bb12-20020a170902bc8c00b00178a40672eamr11495880plb.56.1665271064101;
        Sat, 08 Oct 2022 16:17:44 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b00180daa59314sm1963597plh.125.2022.10.08.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 16:17:43 -0700 (PDT)
Date:   Sun, 9 Oct 2022 12:17:37 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v2][next] dlm: Replace one-element array with flexible-array
 member
Message-ID: <Y0IFEUjwXGZFf7bB@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in struct dlm_ls, and refactor the rest of the
code, accordingly.

We strive to make changes that don't produce any before/after binary
output differeces as that makes it easier for the reviewer to accept the
patch. In this particular instance, it wasn't possible to achieve this
due to the fact that the ls_name[1] size, which is used as the
NUL-terminator space, was hidden within the struct's padding as shown
below.

$ diff <(objdump -M intel -j .text -D dlm.old) <(objdump -M intel -j
.text -D dlm.new)

13778c13778
<     c693:	49 8d bc 24 c0 08 00 	lea    rdi,[r12+0x8c0]
---
>     c693:	49 8d bc 24 c1 08 00 	lea    rdi,[r12+0x8c1]

$ pahole dlm.old -C dlm_ls
...
	int                        ls_namelen;           /*  2232     4 */
	char                       ls_name[1];           /*  2236     1 */

	/* size: 2240, cachelines: 35, members: 90 */
	/* sum members: 2166, holes: 17, sum holes: 71 */
	/* padding: 3 */
	/* paddings: 3, sum paddings: 17 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(8)));

$ pahole dlm.new -C dlm_ls
...
	int                        ls_namelen;           /*  2232     4 */
	char                       ls_name[];            /*  2236     0 */

	/* size: 2240, cachelines: 35, members: 90 */
	/* sum members: 2165, holes: 17, sum holes: 71 */
	/* padding: 4 */
	/* paddings: 3, sum paddings: 17 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(8)));


This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/228
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
My apologies for v2, there was an accidental <Cr> I added on
the CC line which messed up the body of my previus email. 

This patch sets it right.

---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lockspace.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index e34c3d2639a5..ce2e32ed2ede 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -670,7 +670,7 @@ struct dlm_ls {
 	void			*ls_ops_arg;
 
 	int			ls_namelen;
-	char			ls_name[1];
+	char			ls_name[];
 };
 
 /*
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index bae050df7abf..c3a36f3197da 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = -ENOMEM;
 
-	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
+	ls = kzalloc(sizeof(struct dlm_ls) + namelen + 1, GFP_NOFS);
 	if (!ls)
 		goto out;
 	memcpy(ls->ls_name, name, namelen);
-- 
2.37.3

