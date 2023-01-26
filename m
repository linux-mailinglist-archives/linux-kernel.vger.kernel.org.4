Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0096E67CD56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjAZONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAZONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:13:01 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABD22A30
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:12:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id me3so5352859ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HD+YKB7qo81plWmaZPa/cYsWJSDG4HwNyIkyBJORIUM=;
        b=Dx6YA6e6s0uUOkoNUWuNLWhntBC0Iw+tRs8oQJA9VNzwhGREeudmK4B6L+UOCNlhs2
         C1dKx81CxIGJbdQ8sNy1Yg40AWfMYM6lDSVrKhwhJlxLX0Wfp7MwCYBVBrI4E4h7iWzv
         o9+jKnoO555X+DjMckSMEPF0TJwOYsyQohz90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD+YKB7qo81plWmaZPa/cYsWJSDG4HwNyIkyBJORIUM=;
        b=BELAe+L6Q8rF6ONLL9EGDfsXnX6BM5Sba/E0RRF5ZABY1znQUxMUD+pJAXLcDMv3ZK
         eys4CTAI3RuYUOf3Vj/yP1s3SB5a0X3Ojv9ljzlbPXUVYp3yH8xqM3HukueW4w3D8dEW
         jXqgfVv4Btg7aiB4L3aElTHOnr+rM1RmwnsBXDNewDRU+0bXki8klxfecmpQ7QfYNLiO
         Anrubn4sXa2xIL7z+TGHl+bVsm2yuIU9P3Qvi6vZipVJo2KJ/ZMtm/Vm012goM0/0893
         Fllcdeuus0qbnQXvCiQ4P84tT87jEsd4G+wX5DxH4yhvvis1N+7K+rw9KJZ1s567/hM1
         sgzw==
X-Gm-Message-State: AO0yUKXkLnZ/7hfZm5VrnwkOnT8eE9wOzWYLl9MLrnUo8dR//GPT+Fu5
        wYOJPbxEu1I2CjWzaTlVCt2/52VlC437jTiZmAD5uw==
X-Google-Smtp-Source: AK7set/snzoOf5p+A1uMAvJ4y2yTyemLxhP3ls8jgoM4w3IkJhFSAEE1FPD3q33cyVMCOxiTPvv83OxzJVV3rnjO9NA=
X-Received: by 2002:a17:906:8252:b0:878:6f08:39d4 with SMTP id
 f18-20020a170906825200b008786f0839d4mr363948ejx.196.1674742378090; Thu, 26
 Jan 2023 06:12:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza> <Y4TNI8+QVHFuzeZC@tycho.pizza>
 <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
 <Y5IjpyLHIF8PgQ6l@tycho.pizza> <Y6C4ni3wpkaYxmLw@tycho.pizza> <Y7RA6pzP82mNWxOQ@tycho.pizza>
In-Reply-To: <Y7RA6pzP82mNWxOQ@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jan 2023 15:12:46 +0100
Message-ID: <CAJfpegtPj1p73O6LQj-9WFkoFAFt2EZe1cj1K1gK1AFqLYW38w@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 at 15:51, Tycho Andersen <tycho@tycho.pizza> wrote:

> Happy new year all. Any update here?

Applied, thanks.

Miklos
