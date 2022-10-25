Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204CA60C4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiJYHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJYHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:09:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433CC90F2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:09:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g16so5588785pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZFcIJPP7hP36ArInBNW8n2j0uX5C3njSQrmI4vsBk8=;
        b=kUSm5ZCSBJgk8oteDOQJnkf3uZTQm9x0gut/1rlTmEEvwP1LEcZErJ2U5WTh3Uplrv
         pRSyTWsIU4D+rVWyIByZ94fQgcgtcUAg81oLQHb9dE1V2Gc1lBCnxZ9CygD3ypvoBVJF
         qs/R/oN7x30Jv5ghBN7hO6Gx1GBQeNkiQ56wy80F6G2+uWK0MolWzKSPkoRsoNgNQx2k
         DbTkkVDsrgn02q4YuhUKvYBgxm3Masub/EV7oWXYSUWB6GK2OTeH8bALif6MLFSWou3J
         dmrBMFd2AVVU1LAiUdpXakqsfcIfHT9oDtC3oIo2uIcfXF6y+AGvpofsz6VsAHWER0Ew
         8u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZFcIJPP7hP36ArInBNW8n2j0uX5C3njSQrmI4vsBk8=;
        b=fAu+PyzCRNLKXy+7ioTx/k+s/0jbLbGTb9uBdPpSJ6XtNREhD6KAvS5EmcPAn7Q0es
         6cvsXELqihM67SiLv/IX/ayTI0Q9U4cEpapUqahPKVIihoUcxtG+5/87JwUn9ntjwclA
         APqMqt75JQsc51v4tB9+yzMhYdOjkWzDWJgP90DkrezZl5ZDIk4wrlAOtfYMzZResY+t
         shsQYzP1HsHHOh47scj+lIBoLOOMZllJ2RQyckz6Fw8dYhVmhvWSyA4YtPLzyEHQEAbo
         VF2O/OGJdVbHuobRR+QE5c0SmfNhf2vumi0O4IC/Y7EEcFkQb0gClqdpw0pPilE0LU9r
         waZA==
X-Gm-Message-State: ACrzQf2YSz2sdKZOUGZ0I6Gqv3LTAkJdf64N6FNtDT5Nr2ydKGLWU8K8
        Gn5TLuzYP7I2JzZNIW6uqGUQQQ82RkA=
X-Google-Smtp-Source: AMsMyM4iQkuOwvB0gAo8SC7YJLmwm9CIkazDhlY/LocDJ2iH4YeSmL+ZGR91wDRUwQGmGoqUTJu4Xw==
X-Received: by 2002:a05:6a00:b50:b0:566:917:e588 with SMTP id p16-20020a056a000b5000b005660917e588mr37976093pfo.2.1666681761552;
        Tue, 25 Oct 2022 00:09:21 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a384e00b00212c27abcaesm4972919pjf.17.2022.10.25.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:09:21 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1onE3r-0007dJ-C3 ; Tue, 25 Oct 2022 16:09:19 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     Liam.Howlett@Oracle.com, yang.lee@linux.alibaba.com,
        yuzhao@google.com
Cc:     catalin.marinas@arm.com, david@redhat.com, dhowells@redhat.com,
        dave@stgolabs.net, willy@infradead.org, sj@kernel.org,
        svens@linux.ibm.com, vbabka@suse.cz, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: v6.1-rc1, remap_file_pages() and vma linked list?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29343.1666681759.1@jrobl>
Date:   Tue, 25 Oct 2022 16:09:19 +0900
Message-ID: <29344.1666681759@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux-v4.10 has a commit
	48f7df329474 2016-02-18 mm: fix regression in remap_file_pages() emulation
and it contains a small test program where remap_file_pages() will split
a region into two VMAs.

Linux-v6.1-rc1 remap_file_pages() doesn't pass that old test.
I tried investigation, but I am not good in this tech field. I could
only find there may be related to the commit
	763ecb035029 2022-09-26 mm: remove the vma linked list
but I am not sure.
How can we make the old test pass?
"Don't use remap_file_pages()" or "Ignore such old test" is not an
option.


J. R. Okajima
