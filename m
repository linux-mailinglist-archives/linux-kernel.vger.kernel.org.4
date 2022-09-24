Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE75E8BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIXK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiIXK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:58:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA0DF68E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:58:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2469427pjm.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=f0A/B/1Y3TRoA3sh7M3D2FQIVZAEG73UZGr/wk8WWGA=;
        b=Y7CnBb3tlTqtGvgymKMlQrz8yDKBA0cdSKUiBDW80CnP5L5UgilGDU01XbsOi379gn
         7yU56Dezy+OTOHPpnx1Ss0wyZ6lH3pN53Hq2t1ZuENUed6llDneMDi9WIOl6I3sMB4wX
         aslAiJ6qtgjOX473eXdlsDUfnKndBpnHM7FHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=f0A/B/1Y3TRoA3sh7M3D2FQIVZAEG73UZGr/wk8WWGA=;
        b=OSJuByTNOacjd00I65gHJO0pV3WBWE9hDvcH5c21u6SXUp1QSvzJJ92msSTpo6aZmh
         0ku6/jDYJ+f+K7+t0TmbbiJEmtM3G9487v6LDpq8Fw07y/mr3rv9k1ah0FM+lMDK76CX
         Y7l58RBPYGuEFyKf0MRzO2kavb6GY4nSuWgXMuh4C+Zhd5UaJAfUFaLPGHzgKYyL5+iC
         dfxnKGO35Cnb0g0vv3ip/5e/XyMjKQFQsmntWgIfvWM1UBxoe6oNCnljQSNqsR2GfVjx
         QS7+qt9kNNGwiCnNrORzqa1+LOiSFai+RUNjQj+tE/yoODc81n0M94NwUEC61XqYuVzC
         f/8g==
X-Gm-Message-State: ACrzQf3uRKMlvjKrZa4Xd0T/x8GoksRYtDJ3s1sG0cY7KjOuUkUtnwpU
        Vn2kM58K0loevrZAnONF8Vl7Ulfl6Wr3Vg==
X-Google-Smtp-Source: AMsMyM6Ibqs6gN7Ws5uZ4T5XzEsthwUDJ/aEgUlUBk+GjPja1Ot00vqwwQJ/pUpheK8cJdsnOM+kTg==
X-Received: by 2002:a17:902:b692:b0:176:d346:b56f with SMTP id c18-20020a170902b69200b00176d346b56fmr12488531pls.140.1664017134431;
        Sat, 24 Sep 2022 03:58:54 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ad20100b00203c0a1d56bsm3085255pju.35.2022.09.24.03.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 03:58:53 -0700 (PDT)
Date:   Sat, 24 Sep 2022 19:58:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 12/18] printk: Prepare for SCRU console list
 protection
Message-ID: <Yy7i6R0etO48i4dF@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-13-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide a SRCU protected variant to walk the console list.
> 
> Preperatory change for a new console infrastructure which operates
> independent of console BKL.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
