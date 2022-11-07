Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CBA61FD8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiKGS3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiKGS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:29:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251EF1583A;
        Mon,  7 Nov 2022 10:29:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so11095428pjk.1;
        Mon, 07 Nov 2022 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eN4gCo4viSKLR9l2H7SMr1s7pIJk6iyJI80l9uCghwc=;
        b=Pm/75p3+d7EjBEmeEpXn5RdHbax0ol8g7SL55o+KoP3ZyVkBFHOU9GJZhSx007XWC2
         ZUnTZPlEoKv5dC30DUOhS9E+FSDz62FOIHAD+ZCFb9ctohP6O8LoO5ceB7hQiKLnqePR
         +z6D9mlxa67Ruln3rGnb0skJZ/A9g61014DauJW0KX2eu0ZQGJuFlvi0X8cpoum4BqDh
         ImpuzePwgneNg6HZ1dmyenTYv1smIt/EcN55Iwt44W0tVl+0RNAg/xCMFzNJ+kyqWstX
         GI477szKZX2v7cmRrqwHTvD1M2My5y6TZyICI120zy6KWwVb4yL43OV2NDkd4p9TuvRv
         VY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN4gCo4viSKLR9l2H7SMr1s7pIJk6iyJI80l9uCghwc=;
        b=D2HwQd0UyOPpdk60xNVHlLgnn5Yv+CCqXfX2OqQfeLT3EImJFlGG7s6EhmRTlbdxj+
         q0or6T18dKR+RrSqDMYS38jUBlBYnWL+FTZ4K55jEGLqB4tdKUn6uF717Ue4XZjUDPu7
         7uE2o9yWPmtqpyD6JLjwHd14VeMYdGPy6/DUBs075UKiaHT71orrvG90IvqffgcHEdzP
         VNVv9qLhGZ+SDtGAjooJHMEk3nU2oPXc4qPNFlX/g4FCoxmYJgQZrdEFg0x5cQ06Pe3d
         DQANJUBr0/TuFcDgH/OREpXipABuDlk5jJd+kbBhNolYZE5F0QdktQlRsr5bDO/VdcqI
         LXnQ==
X-Gm-Message-State: ACrzQf2Mmo2E9N5wkPME8z1CaSzMmYtiQRj+pHN52BI6zeKuK1oI5Uqd
        kvOH85bN9QnWICGJc8KijG8=
X-Google-Smtp-Source: AMsMyM7VV+hXeDPXk+Tu1I0m04KAH7TXGs8QFRkXWC3dCtUsM1SpAsogWuckuaPCvt0oJ2N5aVCSCQ==
X-Received: by 2002:a17:903:2348:b0:186:970e:739e with SMTP id c8-20020a170903234800b00186970e739emr52469089plh.115.1667845767422;
        Mon, 07 Nov 2022 10:29:27 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id c27-20020aa7953b000000b0053e38ac0ff4sm4825325pfp.115.2022.11.07.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:29:26 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:29:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Tulli <greg.iforce@gmail.com>,
        syzbot <syzbot+4dd880c1184280378821@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, glider@google.com
Subject: Re: [PATCH] Input: iforce - invert valid length check when fetching
 device IDs
Message-ID: <Y2lOg/xnjxNt+vUi@google.com>
References: <0000000000003adfa805ecde42f8@google.com>
 <531fb432-7396-ad37-ecba-3e42e7f56d5c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531fb432-7396-ad37-ecba-3e42e7f56d5c@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 07:47:15PM +0900, Tetsuo Handa wrote:
> syzbot is reporting uninitialized value at iforce_init_device() [1], for
> commit 6ac0aec6b0a6 ("Input: iforce - allow callers supply data buffer
> when fetching device IDs") is checking that valid length is shorter than
> bytes to read. Since iforce_get_id_packet() stores valid length when
> returning 0, the caller needs to check that valid length is longer than or
> equals to bytes to read.
> 
> Link: https://syzkaller.appspot.com/bug?extid=4dd880c1184280378821 [1]
> Reported-by: syzbot <syzbot+4dd880c1184280378821@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 6ac0aec6b0a6 ("Input: iforce - allow callers supply data buffer when fetching device IDs")

Applied, thank you.

-- 
Dmitry
