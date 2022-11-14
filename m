Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5356282E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiKNOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiKNOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:40:51 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD54265F3;
        Mon, 14 Nov 2022 06:40:42 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id z14so18510797wrn.7;
        Mon, 14 Nov 2022 06:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB9I5ZAWCtKhLs2tRpa3Gm4Asdyf5i+TqTp4v6wgnV4=;
        b=y1HDlot7/FYK/pQE1o5PjfBG4Cp0PSk3kHTGXt38w2jxg30o00kv7+QBb6fZWwoE+u
         2g+86det/BDm6B8dee/L4ua+ukcW/853DulWUs5DZr7MHxIsoLwUBb6HRyrKBZ81oVuI
         hdH0d4l1z62CGMsM0XONFmG+WKc63ltxJ/xI1dURTg84rYVnVPytE2K6lQTVwyLd6Bx2
         cJgUWYJrdzBFO12fki4iTg9LwDrbxPI4rzkG9LsWnEcvJhHs+unENfT/W//GOt5A9/wv
         VpGHopZFHX8MFVDzjJkJei/+bmCp0CLEC54U/WUdblYq+RuAp64pI7l0HGJ4o16C0HMy
         8ksw==
X-Gm-Message-State: ANoB5pnoi/x27IhlQSkjrnGQo0oefwNOTL0YW+88a/YUtPBktp4kUqho
        92ugvV2Jo1tcdudSH5GisOY=
X-Google-Smtp-Source: AA0mqf5gcV2w2db+R2nSHxwSW27AHxtczMBvcmJooGoudwALEd21KAK5DO0DMANsAmA9m8z9SPwrcg==
X-Received: by 2002:a5d:6743:0:b0:22e:28fe:39d6 with SMTP id l3-20020a5d6743000000b0022e28fe39d6mr7811102wrw.701.1668436841384;
        Mon, 14 Nov 2022 06:40:41 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003c6bbe910fdsm22597325wmb.9.2022.11.14.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:40:41 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:40:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 02/28] rust: print: add more `pr_*!` levels
Message-ID: <Y3JTZ5sle+/A/CdD@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-3-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:14PM +0100, Miguel Ojeda wrote:
> Currently, only `pr_info!` (for the minimal sample) and
> `pr_emerg!` (for the panic handler) are there.
> 
> Add the other levels as new macros, i.e. `pr_alert!`, `pr_crit!`,
> `pr_err!`, `pr_warn!`, `pr_notice!` and `pr_debug!`.
> 
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
