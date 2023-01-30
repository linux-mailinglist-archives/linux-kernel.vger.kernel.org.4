Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE06805A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjA3Fej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjA3Feh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:34:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890E923C6F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:34:34 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id br9so17369130lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h2DAn1cDWhS4hWbAX5+FKv8Yf9kS0lfsICMw7GzgTVs=;
        b=Oa6bpA0CeS9crFBiT3tsWK1F958FAFINFWMutxHYPjSfQO41s5btefoXXLK9TT29RI
         E6Lz/kDDEertuiGLTGrLVQKuxp9pCsqJWPbEHo46Zs701fVNPtYKAseKbM7Y/Xjd5kut
         zsmZ1ynbiLhqerrBIIpkrPXpUVSELucFhKgl7/fI1NBPLdzi5KB4x/SoAn3QOQAa5ykE
         VRmz9xmlNWZHl2SKLVyH9osfMBXdHrU+ZEpeYNp19P+tgR6pclqZOWGTApyQ04OwQ4W5
         wCzCzdHj9hnQjq6QBQj/quyeSAQhvid7JPG9cUvT2tr+rRzkQ5BNBSCBcSxV+hjM1cr2
         nBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2DAn1cDWhS4hWbAX5+FKv8Yf9kS0lfsICMw7GzgTVs=;
        b=3zIuVQ49UsB87FGeVvnHSE7D+rpjK8e6GO91O8++Z4xNIk/+ntm06eVZKWTz9MQcCW
         ZyK+7W/sNOiZY0mcZnOrMkMxw/MluAetrMCqBM4Tg58g7VK+0vIE9nBJlsOtk+ykg2o1
         O586izH3m62yANsVLQCOBGjsTPPp9wdYUBYrWmKGr9kMlNKZ71G7kBKFL01Ma5ElkfkQ
         bdkMdVQMYuwe6+LMkUPiCUOJLdDJ9hqhcQlgG0xu5luZZ9SgNaqizPOaJeHcts0ktRgC
         UsSR8sFCbszcynotMQkmFvvVOAMWyM8jL2LwXJotOkVDGmRxA7ASnspW1qkkhRV1Mbup
         ty7Q==
X-Gm-Message-State: AFqh2kosfXvmZBAakEYXe8goeCFSY59U3ZBXvHx8Qcp3Fab4JXxDMUH4
        4mZ9DoOsNPXBEoy3sHiSCFzlISk1ZZJ6HIbwxHz46HngD4sMN64=
X-Google-Smtp-Source: AMrXdXtEdkOYXuOyxZRMxkgDYx46tbObgIxk9ho161qExqZpoelxez3nzvioAqUeoze5GshAQlI6B+HtJBfXHmf0UWo=
X-Received: by 2002:a19:ae14:0:b0:4cc:8589:595b with SMTP id
 f20-20020a19ae14000000b004cc8589595bmr6144264lfc.0.1675056872897; Sun, 29 Jan
 2023 21:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-3-wedsonaf@gmail.com>
In-Reply-To: <20230119174036.64046-3-wedsonaf@gmail.com>
From:   Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date:   Mon, 30 Jan 2023 14:33:47 +0900
Message-ID: <CANgtXuPjovOGH7yeM28uRXOUX04KSTrzthqG_s+-77CBVdCCuw@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: types: implement `ForeignOwnable` for `Box<T>`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 2:41 AM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> This allows us to hand ownership of Rust dynamically allocated
> objects to the C side of the kernel.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---

Reviewed-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================
