Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C26288FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiKNTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiKNTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:15:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916A2656C;
        Mon, 14 Nov 2022 11:15:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so12967449pjh.1;
        Mon, 14 Nov 2022 11:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36v5gUBpLgcJSUQwqRiwLsp80Jc3uoS+E8w6Xxeu30A=;
        b=Lrq1SGsh/h58DcJ11Hw1HOf0hbKqOEcqq8+wNMBXe4s2lYB/Kg31XMTaPFCFKc5aQB
         mzKRTsTGzCUXsb3dGiFhjWLInKi8TjgiyQB1ejK5k+jWj7+Gb+4iqY4yvslZL6j5cA/5
         G3kUrThX86oevlypswDZ6GD7XNF+YPxPG7h6C1kf8td+DZlE7X+n+idVkexUksjD3MH+
         UV2CINhcjBNH1p7HkdUeXZEh9bgJajppw8x+VUngopg5zJxVaG3pZWlX5Psd+CzAsfMm
         CROhYczvRvN2FMe14wZaL7v7yx5MA6E2uGrcAZ1HlNAgiMPqVXNvOB067JdDfm4Ov1Aa
         +hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36v5gUBpLgcJSUQwqRiwLsp80Jc3uoS+E8w6Xxeu30A=;
        b=2YOhwkew4/Ad9fRnu4nAVcLopPaBx/WFo4oXYipY1qmHGCsP/xqG+PhlXQ7lP0ArJj
         CsnGYUiDrOiDYK1NrepmZVOhEWF9zT2IGssliLL9lHj4+eGOzf9OvB/sK5ROHqqMM0jr
         Jj/MvovsrwhKuHc7oj0u02gtcZyLDRxjqLIJ0I71HSBt45wfMTHc+3KkAvYusG9R3Gkt
         2Mrpp2zTzJSbgsUgKJJ2QDiQiAueNBSR+8MgxjyTTchG7lWRM9T+4j0s7ROZiVxlv6+N
         jC50jplQS0ZcUzbXTY3JNQL/PI5ohPEjLrbHY76gttFXw5KsQI20hJE+Lra3jOP3rGmJ
         ZBLw==
X-Gm-Message-State: ANoB5pnGq1dgxSZiOEKvp0ukzP7a9B4WtMxNtWc+i/4WR8i1BBpRK/KZ
        WjCoQtD79Thtn3r8O7CMk41/p34amepSeK6FyhtjFJWP1eM=
X-Google-Smtp-Source: AA0mqf6HcqmbOriLzooDOJRI/wFT8MKO0/1BkR9i+ilXDZI1f8IfqeRx2lE5fCdClkvOV2A7x79j/kh6t+2r/nxz1kI=
X-Received: by 2002:a17:90a:8990:b0:212:dc2f:7ee7 with SMTP id
 v16-20020a17090a899000b00212dc2f7ee7mr14696996pjn.172.1668453352083; Mon, 14
 Nov 2022 11:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20221114162207.62559-1-andriy.shevchenko@linux.intel.com> <20221114162207.62559-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221114162207.62559-2-andriy.shevchenko@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Nov 2022 16:15:35 -0300
Message-ID: <CAOMZO5CJvuMUNwPQ7GUQh0dinYSfQ5TTLMawUt7hMVKJD4S3GQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] usb: gadget: hid: Convert to use list_count()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Nov 14, 2022 at 1:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The list API now provides the list_count() to help with counting
> existing nodes in the list. Uilise it.

s/Uilise/Utilise
