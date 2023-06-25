Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B573D0E7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFYMZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFYMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12651EB;
        Sun, 25 Jun 2023 05:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 818E260BB5;
        Sun, 25 Jun 2023 12:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5733EC433C0;
        Sun, 25 Jun 2023 12:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687695941;
        bh=4eKzV/nEmEg6ZMH3mIV+cr00xbbqDh26+e+nlkU4oP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okLhX1rEZgAA6dkk3YBwFKFsZ0QncT8Cw/3ALC7q1q3qhkZu19jujYS5qUL3C/j3y
         Gr1FQeOgeT75mi466Vk2KmJ5cv/bFFfV6928UarKL7IP1cOQ+9GzRYZPGaay1gHtS2
         Jq301l1B0g6/csoWt55hsD467zrTJ1+zco3FPQGQ=
Date:   Sun, 25 Jun 2023 14:25:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] rust: kernel: add basic abstractions for
 device-mapper
Message-ID: <2023062544-speech-impish-9308@gregkh>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
 <20230625121657.3631109-2-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625121657.3631109-2-changxian.cqs@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:16:50PM +0800, Qingsong Chen wrote:
> - Declare `vtable` for basic target operations.
> - Wrap `target_type` to register/unregister target.
> - Wrap `dm_target`/`dm_dev` to handle io request.
> - Add a dummy `bio` wrapper.

Shouldn't this be all different commits, and different files?  A bio
shouldn't be defined in the device_mapper.rs file, as that would prevent
anyone else from accessing it.

thanks,

greg k-h
