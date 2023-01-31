Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AA683900
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjAaWEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjAaWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:04:04 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A55A374
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:04:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5065604854eso181990347b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bj6yFI+Jqx4F9WsIXvREu+uXXbdhQ0Fh4KScDr1Gho=;
        b=Yn/DMYr0HkaQ+d4cI8Uskhlb1rSHfk1uMJTU4naMoFOq8V1QZB1QaxZX9tgOfeOdjs
         0BvNC169zVEnGQ+AHmX3Ae62I88wPw0i9y3l6TDy1wbEqz/BssqbIrHUUbbHyBtCpfCJ
         TgzwaXHphlxJHfqf3JraFV4m8u46E5aOyFuvLpGwXQC8TLAyzD/Cn3LDpzNPkTMQ31kH
         geknPk+VEX4D5BJqPN2ixvifi+ARrf+mx8QwECDx2e+egyI8CbkFxyOlzuEHzcFDZRez
         MAwIuA0k6FyhScbS4Ge6pKaddUXaey3ZXHTeu9rYhLqlZv/ZI2iNfqaITEWyyfKHcO39
         jDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bj6yFI+Jqx4F9WsIXvREu+uXXbdhQ0Fh4KScDr1Gho=;
        b=TugnxC0GaUHKBTiOCw0fngKpg+1QSY6brUgxmZGWatWyVAZOJJtjKlJvmHQbCMobKJ
         XaUDiQr6IF/Eu2n9/LLOuic+ZK0uLpa9zuFk1I2x3/a8RlfdsPGl0uwZxJSKxAaMgnbg
         QwTcC6AxoelUHgBhFDETlji4diau6WKY1CmNC3flQYLLm5W/6DMEaCpctW8xWElIhP11
         RV6r8FwxTwIhSEN9GjbagyXJYMmXa9p2CDgB7Q81If4zmPB9MY7NC4eujHcBj6EfNJPK
         sL3XadDomr0fM8n/Z3jcrkoYTXu1wKQqrQXtJz76DJrLcnapKl+hEhw7lyzWMckLZJo5
         Bj5Q==
X-Gm-Message-State: AO0yUKUO4M/HImrF1wfNhSrxcFW/Yz+OaQ0+TeaabxDYuW/5eh1IoEf1
        t65FKqhlcTU+DE9eDkGgy0HSO0zfMQ==
X-Google-Smtp-Source: AK7set8Mq08QZGYu9srTtL+/nEcTo9Z66I5nk7TsKTDSJkhM0fKef4gF8SEOL7x++II5Djz5q1eGyW+faw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:6cc4:0:b0:7d4:93ff:959e with SMTP id
 h187-20020a256cc4000000b007d493ff959emr56101ybc.45.1675202643190; Tue, 31 Jan
 2023 14:04:03 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:03:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131220355.1603527-1-rmoar@google.com>
Subject: [PATCH v1 0/3] kunit: fix bugs in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the KUnit debugfs logs have a few issues:
1. The results of parameterized tests don=E2=80=99t show up
2. The order of the lines in the logs is sometimes incorrect
3. There are extra new lines in the logs

This patch series aims to fix these issues.

This is an example of a debugfs log prior to these fixes:

   KTAP version 1

   # Subtest: kunit_status
   1..2
 # kunit_status: pass:2 fail:0 skip:0 total:2
 # Totals: pass:2 fail:0 skip:0 total:2
   ok 1 kunit_status_set_failure_test
   ok 2 kunit_status_mark_skipped_test
 ok 1 kunit_status

Note there is an extra line and a few of the lines are out of order.

This is the same debugfs log after the fixes:

   KTAP version 1
   # Subtest: kunit_status
   1..2
   ok 1 kunit_status_set_failure_test
   ok 2 kunit_status_mark_skipped_test
 # kunit_status: pass:2 fail:0 skip:0 total:2
 # Totals: pass:2 fail:0 skip:0 total:2
 ok 4 kunit_status

This is now equivalent to the regular KTAP output for the kunit_status
test.

Thanks!
-Rae

Rae Moar (3):
  kunit: fix bug in debugfs logs of parameterized tests
  kunit: fix bug in the order of lines in debugfs logs
  kunit: fix bug of extra newline characters in debugfs logs

 include/kunit/test.h   |  2 +-
 lib/kunit/debugfs.c    | 13 ++++++++-----
 lib/kunit/kunit-test.c | 36 ++++++++++++++++++++++++------------
 lib/kunit/test.c       | 36 ++++++++++++++++++++++--------------
 4 files changed, 55 insertions(+), 32 deletions(-)


base-commit: 766f4f2514d2d18bcbd60a058188fb502dea5ddf
--=20
2.39.1.456.gfc5497dd1b-goog

