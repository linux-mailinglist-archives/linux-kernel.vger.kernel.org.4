Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04D621AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiKHRq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiKHRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:46:25 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969654B10;
        Tue,  8 Nov 2022 09:46:24 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3321c2a8d4cso140624977b3.5;
        Tue, 08 Nov 2022 09:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUA2K1AbBMJFfTfwqGJd1jVzR2AWp2wFedzCIWEf2r4=;
        b=KfUTWWlUAS1C7xQKtaKPinRXCWB7Lx4OyL4BfuyEtWJkAMZEuV8xBkrS9p/RgWT2aI
         oZks3vsFpcXy/gVlSeXheM2AK5bEI89ZtTlknKSM9lv9jv3ppPSvzeE4XMk9rtkwa90w
         P8WSpgbYJ99W9Dc/SmHJRP37jy1zXjHQNoz5OTXF4z1nTQ6xj+MoBvconPy0H14rM9O9
         nXI5aXW3yeLvoMgVqG8TEYwx/rfPo1LbE5TMlRClvSwgFoh1C2j6KHNWn69ovpjFLQN2
         me02e/HwC4nnmdGCBXo3lo9hBYf/u6+pLhpHA/3b4m19eXi4BjSVAB/aKJDjfUixHMrD
         ApYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUA2K1AbBMJFfTfwqGJd1jVzR2AWp2wFedzCIWEf2r4=;
        b=gGbWQNXHX0JwBJZGXzGylSQU6zyd3L5pdqGlpPeAAdOedTA3otQsBzJDnAkq3SEKRI
         gQbuXrIL60O6bzjx1vyYC1HZu/O7UZ5axqMtllxuGH5ZuP5aGV6zzvi3z1LvdSYKzsKQ
         KkYeFJWn2CBrGVs4pFOu0FSUrsE7nOrFYk6keUZDQoTH63YbvPGSbVtQh3ZdbRo2A6HV
         W4EtFc0cwl2nSJBKlCBQTNRb4PuyU7XKUzLX43sZiZTVRDZCSo5F6/3BU61H4Htzte3p
         Og12lG0fmW6pGP3s/RWnLgOVgxFpp2c2IHmUau2G9WrZhrflw0QiNGUvpOFPF921SmvL
         Alvw==
X-Gm-Message-State: ACrzQf3cR2xEzGzrfplnFA+x6n7y7LAQVO7cvF+o168LrJynHuv3c2n2
        HKjWvqhgmSBqRhmPzlXOjyZt7u0Lq8U3CfO61xiKa99u
X-Google-Smtp-Source: AMsMyM71x9wlwB4HBDK5F5mFBniRn7kkvz/BSMPnLtedcJYQg9SsmVrwMhHMuLHf66AuBA8hVTJI5F7ND0mlSoCX8bE=
X-Received: by 2002:a81:8302:0:b0:36a:a51f:a22b with SMTP id
 t2-20020a818302000000b0036aa51fa22bmr53646393ywf.129.1667929583738; Tue, 08
 Nov 2022 09:46:23 -0800 (PST)
MIME-Version: 1.0
References: <CACMswuMd18=nhvLK2Tw3H84GnDPnhuS_YRNFEDZ5T4B5DJQtBQ@mail.gmail.com>
In-Reply-To: <CACMswuMd18=nhvLK2Tw3H84GnDPnhuS_YRNFEDZ5T4B5DJQtBQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 8 Nov 2022 18:46:12 +0100
Message-ID: <CANiq72=jipHXHEh9o6GLiper2qi_mcrA-fE_rk32Ji_CkORZKw@mail.gmail.com>
Subject: Re: nvme driver: possible missing `unregister_irq`
To:     Dennis Dai <dzy.0424thu@gmail.com>
Cc:     Andreas Hindborg <andreas@metaspace.dk>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 6:18 PM Dennis Dai <dzy.0424thu@gmail.com> wrote:
>
> I was inspecting the rust nvme driver [1] and would like know if the following
> code contains a missing unregister or I missed anything

(Cc'ing Andreas and fixing Wedson's email -- please do so in the
future, thanks!)

Cheers,
Miguel
