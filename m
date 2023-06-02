Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD8171F81C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjFBBk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjFBBkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:40:22 -0400
X-Greylist: delayed 75 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 18:40:12 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CCF2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:40:12 -0700 (PDT)
X-QQ-mid: bizesmtp72t1685669910tvbasghm
Received: from localhost.localdomain ( [113.120.117.19])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Jun 2023 09:38:28 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: Usw2mCIyiSCmTmTTQKIvcFB7LX5oNcuPR3xfSuGTL3k5cu4wy+6yuW3z8lWlZ
        4pvlW6LlKfEEBnsGdWdk0sw9boOAHHsxcs41NsTu1v3tvHsOkdqLXY9mi7OlGsKqX7o/zXS
        uqMwsw1j1iNoFbYWwCyw+bxX2C5xYNW1mhy+XmVDtj/0wNqjY0C1UzNW1UhC7H8K3fV/C0h
        jfdraxQfkVcvd+xcPcYVcpFFjFKerF4zZTseUj2HZXc1OB41MLRuWwCVFO/Bru577lZvzfE
        5j2CZKXSaDbc2kqhHu2UW0xbeQxK7YMDZWQITa3xf4yIkfCATgVGs2D6rQLiwKkkca876yV
        gS4d/f0bd9LFfX+fEXAyywoy5xFeA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10485070722005561613
From:   Jialu Xu <xujialu@vimux.org>
To:     cmllamas@google.com
Cc:     gregkh@linuxfoundation.org, cristian.ciocaltea@collabora.com,
        masahiroy@kernel.org, vipinsh@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] scripts/tags.sh: improve compiled sources generation
Date:   Fri,  2 Jun 2023 09:38:04 +0800
Message-Id: <20230602013804.940679-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZHjW9RJ/jinVe5F/@google.com>
References: <ZHjW9RJ/jinVe5F/@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a test log of `time make COMPILED_SOURCE=1 cscope`

  # git show
  commit 71f226c00c8a87de4698eda7d2a25e9b602d08e2 (HEAD -> tags.sh)
  Author: Jialu Xu <xujialu@vimux.org>
  Date:   Sat May 6 16:52:13 2023 +0800

      scripts/tags.sh: improve compiled sources generation
      
      Use grep instead of sed for all compiled sources generation, it is three
      times more efficient.

  diff --git a/scripts/tags.sh b/scripts/tags.sh
  index ea31640b26715..938dba219534a 100755
  --- a/scripts/tags.sh
  +++ b/scripts/tags.sh
  @@ -98,7 +98,7 @@ all_compiled_sources()
          {
                  echo include/generated/autoconf.h
                  find $ignore -name "*.cmd" -exec \
  -                       sed -n -E 's/^source_.* (.*)/\1/p; s/^  (\S.*) \\/\1/p' {} \+ |
  +                       grep -Poh '(?<=^  )\S+|(?<== )\S+[^\\](?=$)' {} \+ |
                  awk '!a[$0]++'
          } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
          sort -u
  # time make COMPILED_SOURCE=1 cscope
    GEN     cscope

  real	0m3.869s
  user	0m4.254s
  sys	0m0.389s
  # time make COMPILED_SOURCE=1 cscope
    GEN     cscope

  real	0m3.880s
  user	0m4.202s
  sys	0m0.428s
  # git revert HEAD
  [tags.sh 4dc58acca6240] Revert "scripts/tags.sh: improve compiled sources generation"
   1 file changed, 1 insertion(+), 1 deletion(-)
  # git show
  commit 4dc58acca6240364a2303b9d9a4f55db159d60c4 (HEAD -> tags.sh)
  Author: Jialu Xu <xujialu@vimux.org>
  Date:   Fri Jun 2 08:06:09 2023 +0800

      Revert "scripts/tags.sh: improve compiled sources generation"
      
      This reverts commit 71f226c00c8a87de4698eda7d2a25e9b602d08e2.

  diff --git a/scripts/tags.sh b/scripts/tags.sh
  index 938dba219534a..ea31640b26715 100755
  --- a/scripts/tags.sh
  +++ b/scripts/tags.sh
  @@ -98,7 +98,7 @@ all_compiled_sources()
          {
                  echo include/generated/autoconf.h
                  find $ignore -name "*.cmd" -exec \
  -                       grep -Poh '(?<=^  )\S+|(?<== )\S+[^\\](?=$)' {} \+ |
  +                       sed -n -E 's/^source_.* (.*)/\1/p; s/^  (\S.*) \\/\1/p' {} \+ |
                  awk '!a[$0]++'
          } | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
          sort -u
  # time make COMPILED_SOURCE=1 cscope
    GEN     cscope

  real	0m15.855s
  user	0m16.308s
  sys	0m0.536s
  # time make COMPILED_SOURCE=1 cscope
    GEN     cscope

  real	0m16.043s
  user	0m16.489s
  sys	0m0.493s

