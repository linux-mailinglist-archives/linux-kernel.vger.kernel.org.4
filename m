Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF675E700A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiIVXB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIVXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:01:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92455106F75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:01:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so9755433ybs.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=xIPxWZvtrZj2PCVmNYgTZV2cVLONp7vwiAajdN4VBnk=;
        b=JQTJRLBjr1O/tPQvd1W/jAn3ZOBtkPrYgGBerwBUQHWwmwpbvU79F48aOA1tXfA3D9
         M4dY6xdwKy6SVVAIqVe9rfL8JcGUksmTDj2aKFgg049QVvwA29/o9E8rSK1xxt1K5mc4
         PwK1qilwCuAB4MUQ92rV63DcwaHvZi94mS5DyuUXQ99MczvCVDEh7kVB5hML36n09qmT
         Pf3AMNGuRh4f307ooFwBP5DxbOojPfAz2L53nCr3e0wYa1ZJb+SaCFUHvEKnrmgolVsn
         8WIrkXidt4Q74cN8Sy7gvf7gea1kwDMD1iNJ93ND2dWxcXKiag7CABIJuMjLVmNOpvpQ
         P6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xIPxWZvtrZj2PCVmNYgTZV2cVLONp7vwiAajdN4VBnk=;
        b=NGW3u1m3zG/NhEt6bKS8dMD8505gq/2sV1yYrpnR3SU/uxrE6MJXNgGYVT+3NkKi6Q
         S8JnSYHSH/t0sYrsIp4rGVTVCoReJNIG75pWNjNy1RJ5fRUDo3xd5Bsvd+O/lGSw4g99
         KelWrwjVEdauJ0Ztb0mPrpQR1m/naSttF8Qpi2r/yBVmVgORPnS6b4uuzLeLCFzGqDwy
         QQ2pncYO6pOcPnoF2id6E3R7EwXEKyWgeRagf+RWV2qF2dEdrZ7le7lVa16KuA3qXttT
         gbLYWZB4tVTGNISJkBfypKftF0NcQimVEptQgGeyP0PMP34ThrSqhfpW0mueNkd20xUW
         zrBw==
X-Gm-Message-State: ACrzQf244yrxKoOdLvK0NPoBtNbuh1cBBjWCObjFRJjOieKogEROu+DW
        gYxwzsEncogf4hJQtS2vXHCFiOcvFN9Zew==
X-Google-Smtp-Source: AMsMyM5v0YHLzICKDfCbg+lZaan9A+SBFhl3biNV58tSKM38ch+ng/GCr6feXJMC+fa3av41EWHrCRVkG5OVeg==
X-Received: from dmatlack-n2d-128.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1309])
 (user=dmatlack job=sendgmr) by 2002:a25:8547:0:b0:672:ca9c:d33f with SMTP id
 f7-20020a258547000000b00672ca9cd33fmr6528441ybn.270.1663887681807; Thu, 22
 Sep 2022 16:01:21 -0700 (PDT)
Date:   Thu, 22 Sep 2022 16:01:14 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922230114.3556322-1-dmatlack@google.com>
Subject: [PATCH] get_maintainer: Gracefully handle files with authors but no signers
From:   David Matlack <dmatlack@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gracefully handle the case where a file has no signers (e.g. has not
been modified within the last year) but does have authors (e.g. because
there are local commits that modifies the file without Signed-off-by
tags). This scenario could happen for developers whose workflow is to
add Signed-off-by tags as part of git-format-patch rather than as part
of git-commit.

Today this scenario results in the following non-sensical output from
get_maintainer.pl:

  Bad divisor in main::vcs_assign: 0
  "GitAuthor: David Matlack" <dmatlack@google.com> (authored:1/1=100%,added_lines:9/9=100%,removed_lines:3/3=100%)

There are two issues with this output: the "Bad divisor" error and the
garbled author name. Both stem from this line in vcs_find_signers():

  return (0, \@signatures, \@authors, \@stats) if !@signatures;

Returning 0 for the number of commits and a non-empty list for the
authors results in the "Bad divisor". The garbled author name comes from
the fact that @authors is the raw, unparsed, output line from git-log.
Code later in vcs_find_signers() actually parses out the name and drops
the "GitAuthor: " prefix.

Fix this by returning an empty list instead of @authors and @stats to
make them coherent with the fact that commits is 0.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..69f0e1ac9f90 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1605,7 +1605,7 @@ sub vcs_find_signers {
 
 #    print("stats: <@stats>\n");
 
-    return (0, \@signatures, \@authors, \@stats) if !@signatures;
+    return (0, (), (), ()) if !@signatures;
 
     save_commits_by_author(@lines) if ($interactive);
     save_commits_by_signer(@lines) if ($interactive);

base-commit: bf682942cd26ce9cd5e87f73ae099b383041e782
-- 
2.37.3.998.g577e59143f-goog

