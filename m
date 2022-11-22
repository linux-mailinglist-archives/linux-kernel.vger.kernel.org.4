Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE8634141
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiKVQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiKVQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:15:59 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345D73431
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:13:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b12so11661860wrn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mC90GwNhm6j7BlWHBWFQA6hS+M8xqG7H71ScqSgu+SE=;
        b=duED85v80csEaRq1YyX8RGCan5YsZObsDE+LxOFw2hRKLd4y74hJ6VQpH2h8i42z3a
         Clii+1EG793oZfMdmFqoOXa6/ceHR4g9KwtXM/2o4kfpKIHEwQaVTAIE3wvAVwoB/32u
         wpVuAXugU8a9n8vANtU1W1XTMegemYjVCPGXndxhV8l1D/UznxvyXgXQ+8jCYydRJjfy
         6nXiMTWxIdUjqfx/wRrvMOfOyJbyEsQyeEm+M9vEFOoKFpge1FaGl+okkjKZoQYH3F7y
         R6KCyvD+KFF3Khy2rvirDlDJOuYh1eJzSja6BYJgs7j42ubvK8GD5SxEcVe+FADW1PHF
         IUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC90GwNhm6j7BlWHBWFQA6hS+M8xqG7H71ScqSgu+SE=;
        b=Mw6FQgVD7ezAUM7+PXJ1mKe6M0K3IfgUG7LFXUckJXFY153TGkN1i/7heU7/jtqrxY
         G4U6Ok2t8w560G7CLgrbqZd5OWsi3eYV449fr6GTycvtDo67cIwUUyHlhJsg+SZXfnsd
         LtMq+4kTeG4z+n6G5wJ+GLbDr8KbRN4SAOL2btSYGd6zYby+HWS4aakImbW988TSZZdW
         Hta8wjkl9HJJy1lvWX8nRx11iQ52Gy5KNn8bfNCD8HAzghh/Qb9jvkCWhzbKpBoa1sse
         X2mLfia3WsQbUPBpv20Pxcw18PPiU4T1JLRho4RABIHSeMU0yOU3PgmiG6w/l0XSduNb
         tl/w==
X-Gm-Message-State: ANoB5plEb5fuhB8bpa0aNiaPBhx4dWZ5lkXtxnwc7EgObXk9ayJyS4Eo
        Hpzkhu7QVSsNekJ4R0T7lYY=
X-Google-Smtp-Source: AA0mqf5qnuuB7LLLd0XE2bXOYFU/xJz0C1TnyOb7qcwmV6QYY7frWdzVjqgcGPlabDwcunMKuQIgWg==
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id c12-20020adffb4c000000b002365270735emr3949996wrs.659.1669133629782;
        Tue, 22 Nov 2022 08:13:49 -0800 (PST)
Received: from localhost.localdomain (2001-1ae9-2f0-fa00-5962-fdfb-2a9a-17bd.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:5962:fdfb:2a9a:17bd])
        by smtp.googlemail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm14610846wrp.4.2022.11.22.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:13:48 -0800 (PST)
From:   Petr Skocik <pskocik@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Petr Skocik <pskocik@gmail.com>
Subject: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
Date:   Tue, 22 Nov 2022 17:12:40 +0100
Message-Id: <20221122161240.137570-1-pskocik@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I've never sent a kernel patch before but this one seemed trivial,
so I thought I'd give it a shot.

My issue: kill(-1,s) on Linux doesn't return -ESCHR when it has nothing
to kill.

The code sample below demonstrates the problem, which gets fixed by the
patch:

    #define _GNU_SOURCE
    #include <assert.h>
    #include <errno.h>
    #include <signal.h>
    #include <stdio.h>
    #include <sys/wait.h>
    #include <unistd.h>
    #define VICTIM_UID 4200 //check these are safe to use on your system!
    #define UNUSED_UID 4300
    int main(){
        uid_t r,e,s;
        if(geteuid()) return 1; //requires root privileges

        //pipe to let the parent know when the child has changed ids
        int fds[2]; if(0>pipe(fds)) return 1;
        pid_t pid;
        if(0>(pid=fork())) return 1;
        else if(0==pid){
            setreuid(VICTIM_UID,VICTIM_UID);
            getresuid(&r,&e,&s); printf("child: %u %u %u\n", r,e,s);
            close(fds[0]); close(fds[1]); //let the parent continue
            for(;;) pause();
        }
        close(fds[1]);
        read(fds[0],&(char){0},1); //wait for uid change in the child

        #if 1
        setreuid(VICTIM_UID,(uid_t)-1); seteuid(VICTIM_UID);
        #else
        setresuid(UNUSED_UID,VICTIM_UID,0);
        #endif
        getresuid(&r,&e,&s); printf("parent: %u %u %u\n", r,e,s); //4200 4200 0

        int err = kill(-1,-111); (void)err; //test -EINVAL
        assert(err < 0 &&  errno == EINVAL);

        int rc = kill(-1,SIGTERM); //test 0
        if(rc>=0) wait(0);
        int rc2 = kill(-1,SIGTERM); //test -ESCHR
        printf("1st kill ok==%d; 2nd kill ESRCH==%d\n", rc==0, rc2<0&& errno==ESRCH);
    }

Thank you for considering the patch.

Best regards,
Petr S.


Petr Skocik (1):
  Fix kill(-1,s) returning 0 on 0 kills

 kernel/signal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.25.1

