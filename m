Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6260C0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJYBQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiJYBQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:16:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F0E50501
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:34:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id 13so8824045ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=njSAeeEWS4YTFoFUiTIV452Wm8jZRn/VS5t9bD4jpSw=;
        b=Zs5ZG44XK6uYkMM2kvzLquvdTYQabPJs6GmRjz64lCMMjMcN4yFTyUa3U3l1zZlS/3
         luA9yvHgX+ddv8Olw4MiBPEC0ZtCCkW/eddixOLkvRLZnFOOk84DafQ9XLq0O5QapXzn
         yYbWlG4Rc1xGqRYpgBcXZd9GP+hJg0pZWif6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njSAeeEWS4YTFoFUiTIV452Wm8jZRn/VS5t9bD4jpSw=;
        b=2K0GgiSPBsPQCO5Ztcd3MtRwcdyTtEvpKdILEGiLnkj5xQXegj+ttp2dCpUW0OyjBK
         etHiV7W9uJqt4AbmgctkSbA4Lcui1dwySomZlptymbsY04Wx3xDzcubUUVTiYIGKimf6
         VnikD8tcaLkXhd7g360gR3VGNVhhVID4gwHPRyPGbLOx4h6tmMPylF6nNCL98+1dhv9k
         mablx86BzAICLkybviF0DiEZhOMlsbbrnrHYDFlUyY1Pm7B5AGUMmyqBNOG5uMkMmQC1
         7Ff0Ybnv/3Phygm/F2tvDUYInHF6C6nj9YcELw9WiJMP1zQHXYmPyzoTqLtE1n1fNPbb
         7zIg==
X-Gm-Message-State: ACrzQf3uw4LRIIaOipYF8MSe4KacJwniYyPE67wwul1QWoEMpLL2Ot1z
        IlK/uiQ5TEgDwGFoLzdxjY92/FvIUNWK1088
X-Google-Smtp-Source: AMsMyM7XwpLZrQ1qvtK1Wo+5WcChOIlX5ekmCvU4ItGidsijBJxUBGNZJkXY4NINBfYkRgM8HENPvg==
X-Received: by 2002:a17:907:25c5:b0:783:f5df:900e with SMTP id ae5-20020a17090725c500b00783f5df900emr28995804ejc.491.1666658055424;
        Mon, 24 Oct 2022 17:34:15 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906328f00b007933047f930sm532915ejw.157.2022.10.24.17.34.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:34:13 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id y16so8024826wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:34:13 -0700 (PDT)
X-Received: by 2002:adf:f641:0:b0:236:737f:8e00 with SMTP id
 x1-20020adff641000000b00236737f8e00mr4369053wrp.659.1666658053078; Mon, 24
 Oct 2022 17:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-20-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-20-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:34:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=GCzDu+YvGLCvhwW=2W=CFmZO78smQu6c5xwZoaT86Q@mail.gmail.com>
Message-ID: <CAD=FV=V=GCzDu+YvGLCvhwW=2W=CFmZO78smQu6c5xwZoaT86Q@mail.gmail.com>
Subject: Re: [PATCH printk v2 19/38] kdb: kdb_io: use console_is_enabled()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
