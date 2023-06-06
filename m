Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E936F723EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjFFKFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbjFFKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:05:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE07BE64
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:05:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so8934151a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686045909; x=1688637909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rnMujNjqe1l2Xq3EuAPc0/B+xPfCFxxwqOAJdqo6rxQ=;
        b=nMEHFFK9Rdv3z5BPfTqjdgzouAUlJnqVtRc4BmCdVPAtlFwoKBoMBLmBqdPZWIMUTq
         GdwA+j9/5xoxDx5CDYqmPTQlHkiuVwR0QH4nADhy1sE6RlEtqbFiCIEN39UD8pUiqEH+
         GIkgzP0S5tica754aiTdKaqCQ4O3fdtSUEJgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045909; x=1688637909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnMujNjqe1l2Xq3EuAPc0/B+xPfCFxxwqOAJdqo6rxQ=;
        b=Euq2/+DFOk0fglrNuMlzHjvU/WA7jI4Eiq200Wt1hWkj8aQRzl3RrRpgglsDaep36j
         2+yyGpNUojN+cGJ7RgJefH0zMcZDjyW5wysRqQtFQRbj/USYpsqDuQTqHz7AV6Fj0GqJ
         P7H5dDB2HId1WeFVhc50aQ4A808/6hwatKm+HKl9Ngx9fpp9+umXONNjvdTKfQFrtCM8
         p52MTw3flxgM2as2oxtk0A2os9uMYmyHya1TXRao/TT5xzc0Tu6Bf3Nb/q7WLHpjnDtA
         DSPq9563RFl8cv3fGIciVw6QcA/N8DafBdhJ+sq0m1g4HFbVhYxrgQyRMHJgRsA5WFdI
         dDwQ==
X-Gm-Message-State: AC+VfDxV85G4dK0tZS7fySqEvI/R4YtkoGsK+4ta35ij6Dw7nJwekJhu
        QJDTwb6I/Qqn/P/PAVeXQj2atJjL/gpYJiJOWwIN3A==
X-Google-Smtp-Source: ACHHUZ7ezEZLOJN4hkU6I45f7Eh6IZy9yJfrv0LLAb/WmqVy8pWJCt9YKFsK/unBKYH1os+oupopFWPyVnCxgeWFeqQ=
X-Received: by 2002:a17:907:9809:b0:96a:57fe:3bfb with SMTP id
 ji9-20020a170907980900b0096a57fe3bfbmr1858329ejc.26.1686045909356; Tue, 06
 Jun 2023 03:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001b987605f47b72d3@google.com>
In-Reply-To: <0000000000001b987605f47b72d3@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 12:04:58 +0200
Message-ID: <CAJfpegtY5gpWnT9LqUeaL=QWWDtp9n=YCi9dBWu9cHxZ=7C9Og@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in take_dentry_name_snapshot
To:     syzbot <syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: BUG: unable to handle kernel paging request in
take_dentry_name_snapshot
