Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70FD6B5A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCKKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:37:28 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93011E6EB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 02:37:27 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536c02eea4dso147984637b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 02:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1678531046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWkeebSfJbGROfjN6P7AFQQg4m0f28050lcJ2wytDVY=;
        b=Hs3mq3/Vy8MFaT5UUoVU7ing5Vvo82jutW4nwsFZ8UQbU53fR8LDmdp8uzQtkr43SX
         z0npi1faggB94oIKzaMVlpJlPq9fiGoT01Ib8/q2LHSP6GDA1he16Xs6+eTaJ6ymAq2c
         igzFP1qAAM2Qg2QI3XvpRG3CjPViGsQTYbBOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678531046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWkeebSfJbGROfjN6P7AFQQg4m0f28050lcJ2wytDVY=;
        b=WPPNDez3nX9yqHQhgPtO85azxWq6FyyjfB0VHkDFs88V2kFz/mK8OQT49nFPx33yUG
         CmlX/36QtInoe0xW5o/AGGo4gYZ1Y8B8infHQ0jAX10DBZKq+db3qRaJiN21d8BWm4FC
         aHG6QZEgKXgbdCH5twrFqXel9EybUwGnvEiwFs7KgJt3KnAnD+xtZBw7TX3fNYiPNzFH
         +7ka5raJ7S3ub/7UM2Q689vQj4HSlHuviDyxWo0TdYIY7Rz2xVi54gq3pibdiPPlKQiH
         lPcyn4juhc1pgyPReN3O3hEVOQQtd9Qldmxq9evVGoRZOnOs0k9wRdzGEXWlM6eJVXJv
         GzTg==
X-Gm-Message-State: AO0yUKVv4dLI+HUYzD8AW/tdZ62Ke0y7z9v0elybelqYg8iepR1HdgV7
        pJUGEA3oqQ9XTbYfB76zkpJd4NKlcXZmXm/mh3ejdg==
X-Google-Smtp-Source: AK7set/zT53jfMaTJhyr+9DuEt+z1ce4le7ZoILliGh7A6Ixjk6cKZhd9minwkCYZRmXjEAn6xSG9+Agez3t5kFkq6s=
X-Received: by 2002:a81:ae1d:0:b0:524:5bc5:a3d5 with SMTP id
 m29-20020a81ae1d000000b005245bc5a3d5mr17891444ywh.4.1678531046310; Sat, 11
 Mar 2023 02:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20230311092929.2827-1-richard@nod.at>
In-Reply-To: <20230311092929.2827-1-richard@nod.at>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 11 Mar 2023 19:37:15 +0900
Message-ID: <CAFr9PXkZgW7Ky7LEd1jXJYAOuG-KP5iOyR1MSyYJQP7EAbrBaA@mail.gmail.com>
Subject: Re: [PATCH] ubi: block: Fix missing blk_mq_end_request
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Sat, 11 Mar 2023 at 18:29, Richard Weinberger <richard@nod.at> wrote:
>
> Switching to BLK_MQ_F_BLOCKING wrongly removed the call to
> blk_mq_end_request(). Add it back to have our IOs finished

Machine is booting again. Thanks!

Tested-by: Daniel Palmer <daniel@0x0f.com>

Cheers,

Daniel

---

Sorry if this e-mail doesn't get to the mailing lists. gmail is doing
something wonky and sending e-mails with HTML even with plain text
selected.
The original report bounced for a bunch of recipients due to that.
Guess I'm setting up a better mail client at some point..
