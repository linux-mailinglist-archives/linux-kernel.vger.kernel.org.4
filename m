Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A364AD03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiLMB2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiLMB2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:28:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41561B7A4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:28:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id g14so1842465ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hWQuf6fJb/YVIuJC6Vbc4NCFoWyCtgp9ttcoUw/2b+o=;
        b=pybt8siRm9wNz1tPEEa4FKtsQfYapbuJDgi8IOFLhqgGjmeTg0osExOYX8SSJ+dATK
         oUYIVu+zlrtSSTW7C6VF1OesM8bwgixWdIDgGX+IOmIP8m0Ahi8xASkrf+jtDgyHyLDc
         rOKFgybFwvU3RweGRbLKQPTKBARWbn5divrIct16ITNIzKehxCxGjcPjvQvozDXdJYAl
         bv4Yiahoya3NgszkJyAGN27QHbulDqzryJlIwKjUyNzLiF2A3rLXOAbumoAFVszQZrHr
         7XWO8hJWdHk9xjIcEMPBDIa/Wt087yF2oHloH72kO9na46etUynr3LV/5QSL9ad+Lvwe
         pBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWQuf6fJb/YVIuJC6Vbc4NCFoWyCtgp9ttcoUw/2b+o=;
        b=IyqC3aMwfQGr3PM8IwAREluTPdzvr0b/m2G3aT/mzk7KxsDTdqarIWxmy4qQBr8DU9
         EToszyzTC0CWIC7OeH2RuUUgEqbfCEPrijWqvTYGkJCacw1dIeZVA1+6xj+kmotKQLR0
         WHVJ7kZEudmw2KABe+2F+zw0KMs6adwCzJwwyHYK/GrMSQHnHHqFIp0pQEYCc/JhqI6T
         cV0PKimf5psN1e+NgGMNRjr24WaAQyEyBptj5aEwTJDrDmSvsrn49veg/CXP5LrD0lHJ
         GVXJLB+R5X1aYwxblaDzFrdQI+B5qOOrCVRkDGk/22U/qHt/8Ba/wNKTms2/VXLUmGoX
         RRtQ==
X-Gm-Message-State: ANoB5pma5d0Q7uyx+QogIyJo70iOfyRoPGmdtr9pOmOzuwSi/admVSFB
        Gw3UDHom9ssCMRceWIXDNclbxq2nFgY1D8YCTVphhOzbP2TS
X-Google-Smtp-Source: AA0mqf4OF8rF7Qw7UPY3uQg6pxp6BS1uhWAlqP8axeZcj79T3XipnTAlkKRC5UGJhVe+W2hVQU0qtjk6nq8/8Nq+9zQ=
X-Received: by 2002:a05:651c:19ab:b0:276:66a4:47c3 with SMTP id
 bx43-20020a05651c19ab00b0027666a447c3mr24789792ljb.49.1670894927693; Mon, 12
 Dec 2022 17:28:47 -0800 (PST)
MIME-Version: 1.0
From:   "Seija K." <doremylover123@gmail.com>
Date:   Mon, 12 Dec 2022 20:28:36 -0500
Message-ID: <CAA42iKwtUGyRtYoib5_3A3OpUc49hwEnYpOKN6cp+ViU_E8AMQ@mail.gmail.com>
Subject: [PATCH] tools: Correct pthread API usage
To:     andrii@kernel.org, mykolal@fb.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c8c5905f562d56d38da951a4102f1c14a6e32bad
Author: Seija K. <doremylover123@gmail.com>
Date: Mon Dec 12 11:08:36 2022 -0500

tools: Correct pthread API usage
For POSIX functions, all that is guaranteed is that
a return value of 0 means success, non-zero otherwise.
Checking for "less than" is a mistake
as the error code numbers can be greater than 0.
Signed-off-by: Seija doremylover123@gmail.com

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 74dc0f571dc9..ec8005ebda99 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -726,9 +726,6 @@ static int posix_acl_fix_xattr_common(const void
*value, size_t size)
count = posix_acl_xattr_count(size);
if (count < 0)
return -EINVAL;
- if (count == 0)
- return 0;
-
return count;
}
diff --git a/samples/nitro_enclaves/ne_ioctl_sample.c
b/samples/nitro_enclaves/ne_ioctl_sample.c
index 765b131c7319..b8e3ef6ed0e7 100644
--- a/samples/nitro_enclaves/ne_ioctl_sample.c
+++ b/samples/nitro_enclaves/ne_ioctl_sample.c
@@ -805,7 +805,7 @@ int main(int argc, char *argv[])
printf("Enclave fd %d\n", enclave_fd);
rc = pthread_create(&thread_id, NULL, ne_poll_enclave_fd, (void *)&enclave_fd);
- if (rc < 0) {
+ if (rc) {
printf("Error in thread create [%m]\n");
close(enclave_fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e980188d4124..5264a5987cf1 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -141,7 +141,7 @@ static void do_test(const char *tcp_ca, const
struct bpf_map *sk_stg_map)
}
err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
- if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+ if (CHECK(err, "pthread_create", "err:%d errno:%d\n", err, errno))
goto done;
/* recv total_bytes */
diff --git a/tools/testing/selftests/bpf/test_progs.c
b/tools/testing/selftests/bpf/test_progs.c
index 3fef451d8831..0a839d841778 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -332,7 +332,7 @@ static void reset_affinity(void)
exit(EXIT_ERR_SETUP_INFRA);
}
err = pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
- if (err < 0) {
+ if (err) {
stdio_restore();
fprintf(stderr, "Failed to reset thread affinity: %d!\n", err);
exit(EXIT_ERR_SETUP_INFRA);
@@ -1331,7 +1331,7 @@ static void server_main(void)
data[i].worker_id = i;
data[i].sock_fd = env.worker_socks[i];
rc = pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &data[i]);
- if (rc < 0) {
+ if (rc) {
perror("Failed to launch dispatcher thread");
exit(EXIT_ERR_SETUP_INFRA);
}
diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 65ede506305c..450c84bcf487 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -495,7 +495,7 @@ TEST(epoll9)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -538,7 +538,7 @@ TEST(epoll10)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 1);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -585,7 +585,7 @@ TEST(epoll11)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -634,7 +634,7 @@ TEST(epoll12)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -679,7 +679,7 @@ TEST(epoll13)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -722,7 +722,7 @@ TEST(epoll14)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 1);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -769,7 +769,7 @@ TEST(epoll15)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -818,7 +818,7 @@ TEST(epoll16)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1223,7 +1223,7 @@ TEST(epoll25)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1275,7 +1275,7 @@ TEST(epoll26)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1327,7 +1327,7 @@ TEST(epoll27)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 1);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1379,7 +1379,7 @@ TEST(epoll28)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 1);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1431,7 +1431,7 @@ TEST(epoll29)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1482,7 +1482,7 @@ TEST(epoll30)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1533,7 +1533,7 @@ TEST(epoll31)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 1);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1584,7 +1584,7 @@ TEST(epoll32)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 1);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1635,7 +1635,7 @@ TEST(epoll33)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1687,7 +1687,7 @@ TEST(epoll34)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1739,7 +1739,7 @@ TEST(epoll35)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1791,7 +1791,7 @@ TEST(epoll36)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1848,7 +1848,7 @@ TEST(epoll37)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1905,7 +1905,7 @@ TEST(epoll38)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -1962,7 +1962,7 @@ TEST(epoll39)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2019,7 +2019,7 @@ TEST(epoll40)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2071,7 +2071,7 @@ TEST(epoll41)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2123,7 +2123,7 @@ TEST(epoll42)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2175,7 +2175,7 @@ TEST(epoll43)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2227,7 +2227,7 @@ TEST(epoll44)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2284,7 +2284,7 @@ TEST(epoll45)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2336,7 +2336,7 @@ TEST(epoll46)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2393,7 +2393,7 @@ TEST(epoll47)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2445,7 +2445,7 @@ TEST(epoll48)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_TRUE((ctx.count == 2) || (ctx.count == 3));
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2739,7 +2739,7 @@ TEST(epoll53)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2804,7 +2804,7 @@ TEST(epoll54)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2869,7 +2869,7 @@ TEST(epoll55)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -2934,7 +2934,7 @@ TEST(epoll56)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -3004,7 +3004,7 @@ TEST(epoll57)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -3074,7 +3074,7 @@ TEST(epoll58)
ASSERT_EQ(pthread_join(ctx.waiter, NULL), 0);
EXPECT_EQ(ctx.count, 2);
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
@@ -3144,7 +3144,7 @@ TEST(epoll59)
;
ctx.count = 1;
}
- if (pthread_tryjoin_np(emitter, NULL) < 0) {
+ if (pthread_tryjoin_np(emitter, NULL)) {
pthread_kill(emitter, SIGUSR1);
pthread_join(emitter, NULL);
}
diff --git a/tools/testing/selftests/mount/nosymfollow-test.c
b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..d1a3a38cf1ca 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -121,7 +121,7 @@ static void setup_symlink(void)
die("creat failed: %s\n", strerror(errno));
err = symlink(DATA, LINK);
- if (err < 0)
+ if (err)
die("symlink failed: %s\n", strerror(errno));
if (close(data) != 0)
diff --git a/tools/testing/selftests/nci/nci_dev.c
b/tools/testing/selftests/nci/nci_dev.c
index 162c41e9bcae..b8fe6b9d992f 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -438,7 +438,7 @@ FIXTURE_SETUP(NCI)
else
rc = pthread_create(&thread_t, NULL, virtual_dev_open,
(void *)&self->virtual_nci_fd);
- ASSERT_GT(rc, -1);
+ ASSERT_EQ(rc, 0);
rc = send_cmd_with_idx(self->sd, self->fid, self->pid,
NFC_CMD_DEV_UP, self->dev_idex);
@@ -509,7 +509,7 @@ FIXTURE_TEARDOWN(NCI)
rc = pthread_create(&thread_t, NULL, virtual_deinit,
(void *)&self->virtual_nci_fd);
- ASSERT_GT(rc, -1);
+ ASSERT_EQ(rc, 0);
rc = send_cmd_with_idx(self->sd, self->fid, self->pid,
NFC_CMD_DEV_DOWN, self->dev_idex);
EXPECT_EQ(rc, 0);
@@ -590,7 +590,7 @@ int start_polling(int dev_idx, int proto, int
virtual_fd, int sd, int fid, int p
rc = pthread_create(&thread_t, NULL, virtual_poll_start,
(void *)&virtual_fd);
- if (rc < 0)
+ if (rc != 0)
return rc;
rc = send_cmd_mt_nla(sd, fid, pid, NFC_CMD_START_POLL, 2, nla_start_poll_type,
@@ -610,7 +610,7 @@ int stop_polling(int dev_idx, int virtual_fd, int
sd, int fid, int pid)
rc = pthread_create(&thread_t, NULL, virtual_poll_stop,
(void *)&virtual_fd);
- if (rc < 0)
+ if (rc != 0)
return rc;
rc = send_cmd_with_idx(sd, fid, pid,
@@ -874,7 +874,7 @@ TEST_F(NCI, deinit)
else
rc = pthread_create(&thread_t, NULL, virtual_deinit,
(void *)&self->virtual_nci_fd);
- ASSERT_GT(rc, -1);
+ ASSERT_EQ(rc, 0);
rc = send_cmd_with_idx(self->sd, self->fid, self->pid,
NFC_CMD_DEV_DOWN, self->dev_idex);
diff --git a/tools/testing/selftests/sync/sync.c
b/tools/testing/selftests/sync/sync.c
index 7741c0518d18..df199ed386a2 100644
--- a/tools/testing/selftests/sync/sync.c
+++ b/tools/testing/selftests/sync/sync.c
@@ -75,7 +75,7 @@ int sync_merge(const char *name, int fd1, int fd2)
data.name[sizeof(data.name) - 1] = '\0';
err = ioctl(fd1, SYNC_IOC_MERGE, &data);
- if (err < 0)
+ if (err)
return err;
return data.fence;
@@ -92,7 +92,7 @@ static struct sync_file_info *sync_file_info(int fd)
return NULL;
err = ioctl(fd, SYNC_IOC_FILE_INFO, info);
- if (err < 0) {
+ if (err) {
free(info);
return NULL;
}
@@ -112,7 +112,7 @@ static struct sync_file_info *sync_file_info(int fd)
info->sync_fence_info = (uint64_t)(unsigned long)fence_info;
err = ioctl(fd, SYNC_IOC_FILE_INFO, info);
- if (err < 0) {
+ if (err) {
free(fence_info);
free(info);
return NULL;
@@ -202,7 +202,7 @@ int sw_sync_fence_create(int fd, const char *name,
unsigned int value)
data.name[sizeof(data.name) - 1] = '\0';
err = ioctl(fd, SW_SYNC_IOC_CREATE_FENCE, &data);
- if (err < 0)
+ if (err)
return err;
return data.fence;
diff --git a/tools/testing/selftests/timers/posix_timers.c
b/tools/testing/selftests/timers/posix_timers.c
index 0ba500056e63..ab490764bfe4 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -103,13 +103,13 @@ static int check_itimer(int which)
signal(SIGALRM, sig_handler);
err = gettimeofday(&start, NULL);
- if (err < 0) {
+ if (err) {
perror("Can't call gettimeofday()\n");
return -1;
}
err = setitimer(which, &val, NULL);
- if (err < 0) {
+ if (err) {
perror("Can't set timer\n");
return -1;
}
@@ -122,7 +122,7 @@ static int check_itimer(int which)
idle_loop();
err = gettimeofday(&end, NULL);
- if (err < 0) {
+ if (err) {
perror("Can't call gettimeofday()\n");
return -1;
}
@@ -154,20 +154,20 @@ static int check_timer_create(int which)
done = 0;
err = timer_create(which, NULL, &id);
- if (err < 0) {
+ if (err) {
perror("Can't create timer\n");
return -1;
}
signal(SIGALRM, sig_handler);
err = gettimeofday(&start, NULL);
- if (err < 0) {
+ if (err) {
perror("Can't call gettimeofday()\n");
return -1;
}
err = timer_settime(id, 0, &val, NULL);
- if (err < 0) {
+ if (err) {
perror("Can't set timer\n");
return -1;
}
@@ -175,7 +175,7 @@ static int check_timer_create(int which)
user_loop();
err = gettimeofday(&end, NULL);
- if (err < 0) {
+ if (err) {
perror("Can't call gettimeofday()\n");
return -1;
}
diff --git a/tools/usb/ffs-test.c b/tools/usb/ffs-test.c
index 22b938fbdfb7..f455a3352513 100644
--- a/tools/usb/ffs-test.c
+++ b/tools/usb/ffs-test.c
@@ -465,7 +465,7 @@ static void start_thread(struct thread *t)
{
debug("%s: starting\n", t->filename);
- die_on(pthread_create(&t->id, NULL, start_thread_helper, t) < 0,
+ die_on(pthread_create(&t->id, NULL, start_thread_helper, t),
"pthread_create(%s)", t->filename);
}
@@ -473,7 +473,7 @@ static void join_thread(struct thread *t)
{
int ret = pthread_join(t->id, NULL);
- if (ret < 0)
+ if (ret)
err("%s: joining thread", t->filename);
else
debug("%s: joined\n", t->filename);
