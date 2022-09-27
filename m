Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A795ECD23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiI0Tsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiI0Tsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:48:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E91B85CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:48:40 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g15-20020aa7874f000000b0053e8b9630c7so6249201pfo.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=1YKVTBJ5EREw3IjhgTBaoep2hn4xpy2tYb5P/5IEaSg=;
        b=A9RxIwk81YgJHOsL4/0dy0uw4sUTSyrvi14CwlVnD74mshSJZXXnbYCu9MYJ5BRVGf
         ECvPFm/EFd/CNnlC8tjQs05W6XJNNMlNZydxHNqDMdMoTvxlCcPUdWZB6QsH5cnCxmvc
         N8KCfLfiWC+cAdepoGW9toJkdc+LWIihGpJlkDpwTLplsNjV2VHstSC5lutyG9VSDtHe
         5XaGX0Py3k5yppSHf0U8dNbLf1y9h9uEASHe1ysJWir+MS3+rr91mXp+Rc+y4K8X07Y0
         /+Px97/CjtvDu8gyL00g5iOvtRxw6lnWQLITB3lCkRSZ5AWUvGdQFQhv6ZEme+entAAs
         56BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1YKVTBJ5EREw3IjhgTBaoep2hn4xpy2tYb5P/5IEaSg=;
        b=eBz8RTst9M1xFax/UYAo7k35PbKLCDOYWLngTwP/fReWQ6GMhmm/hxI2kV7rBGG/Rj
         ova0uiynYdBpoqBeUcAlNPrthw2ucS8NvaABb+1JpnT2K6NGu/U4qtrzrGXwY/HTL5Q7
         pAIyxfnw7rKr9QFfNV1QroknDA6lWjjvu71jkdte6K6cK2mg805TZYoY7iKuACA0YWM1
         b6xwffOW6bA84FU3i1dVwY0uyqF+nsq1cUC+UkFB/noFi5Fzt9BdKp5cyqnEb6ZnrxZh
         kLCRdhndLdlipDmx4cpI3zQRoIKrpJTW4OJMFrWM7g61QTawaJaoNq2IlNhgYVmgIhsu
         bddQ==
X-Gm-Message-State: ACrzQf0N5cBWaFuehUL+St8Ugf2qXKc0t0LZzrcCELP7W5l0PsLmFpcU
        ZLtxbT+oCeAVntFFK9rr8+x/6jRa111t6g==
X-Google-Smtp-Source: AMsMyM6FOqkjrwLGTx3nQ1YTw9uNzKBLqc9pQTVz49CLZUbf6wWR0xTSGQvQXrFgCAWxm57G3OKeUEf6TAUgwQ==
X-Received: from dmatlack-n2d-128.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1309])
 (user=dmatlack job=sendgmr) by 2002:a17:90b:118f:b0:205:dbdd:c931 with SMTP
 id gk15-20020a17090b118f00b00205dbddc931mr297844pjb.1.1664308119267; Tue, 27
 Sep 2022 12:48:39 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:48:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927194834.992677-1-dmatlack@google.com>
Subject: [PATCH v2] get_maintainer: Gracefully handle files with authors but
 no signers
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
v2:
 - Return empty arrays by reference instead of by value [Joe]

v1: https://lore.kernel.org/lkml/20220922230114.3556322-1-dmatlack@google.com/

 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..5e888432475e 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1605,7 +1605,7 @@ sub vcs_find_signers {
 
 #    print("stats: <@stats>\n");
 
-    return (0, \@signatures, \@authors, \@stats) if !@signatures;
+    return (0, \(), \(), \()) if !@signatures;
 
     save_commits_by_author(@lines) if ($interactive);
     save_commits_by_signer(@lines) if ($interactive);

base-commit: 46452d3786a82bd732ba73fb308ae5cbe4e1e591
-- 
2.37.3.998.g577e59143f-goog

