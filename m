Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECC6099C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJXFYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJXFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:24:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5747B28C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:24:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h14so7308131pjv.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU5BVsJ8MPC4nvdZWcT2dJ2yYF9IwPhzGzbU2K3Mj8k=;
        b=Ssel1FF8vXDAeZ1m+o8/xKO5E78OETuFXhriwQZ7tfmpuxkdCjpPe3SFkrgZkRGWb0
         R6DVm4rL+fQMBgQpX/DXv6i3wIcY261HmaNzsttfdOnBYvfhAXMojQzj1Vf7zhtFSvQN
         snSKPB+Vuw/rOGhQsdYHY0yXLdlhgITOgKS3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU5BVsJ8MPC4nvdZWcT2dJ2yYF9IwPhzGzbU2K3Mj8k=;
        b=kqDtcgzTQvj1qF04fmDVXih2drJUZybacgG7pwmN1+IlEKJTiQg8+myOJWq25LlgRL
         Bndeew/iHbg9tRN4hVvfSYuE03e4hlafUcSHENlIsWUp/TZbLGWOzTjPB3QzelMf/xfQ
         j0GEpDwKQ8OAxiCxADeM3FceUCJkHDBkkimtwIW1Y5fw3LzkwDqlHFFplU9WIp2I9ve6
         uf9+FseuLPROnga1JwZP75WLJB0WcpyHqZO2NGuASdFMcLV3kevEMrz+RnjlyPwWJmKH
         F3i/DHG3FTnLXjLnZvUClpTl1eIMzEeSvpEAYEExLrH5oyQOV5HRT6gpvgT53mMu+BnO
         xzgQ==
X-Gm-Message-State: ACrzQf1c6LR3PwdFUyzmMwa67+FEW+3ylyDztQwykLDz1aWvnnoeJ1Du
        4e3GuXygqO+l2z/zigCYD5TXqg==
X-Google-Smtp-Source: AMsMyM6x6sSHrtlAwrfNBkmXx6onldTZw6Uf2b/twPyfKoxRw/el1ZRujgDu1ZPiWuNJkxI+qXemYQ==
X-Received: by 2002:a17:902:be03:b0:178:6f5d:e979 with SMTP id r3-20020a170902be0300b001786f5de979mr31608752pls.163.1666589041034;
        Sun, 23 Oct 2022 22:24:01 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7f0e:f6a4:8d85:37e4])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902cf0300b001785fa792f4sm18857930plg.243.2022.10.23.22.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 22:24:00 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:23:56 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/38] printk: Convert console_drivers list to
 hlist
Message-ID: <Y1YhbPb07tqiX0g5@google.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/19 17:01), John Ogness wrote:
> Replace the open coded single linked list with a hlist so a conversion
> to SRCU protected list walks can reuse the existing primitives.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
