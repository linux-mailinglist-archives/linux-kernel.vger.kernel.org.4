Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6066A0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAMRps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAMRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB84B88DCB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:32:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id dw9so21662207pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn2AcuBT0fvJkrgHTd2c/hoZ5Zj/kmgAMB/+z6YAX20=;
        b=pWCur2rpr+gspyvTGpRl88k+TALS1FegKvKEk5jy/bubgZifooV2E8xf0QwIy++02H
         S6m6UDBMUkp29rQf5givNCDICZRrcuSYnr5JWNQwoofCzkPg27lB3WM8iemjZkiegent
         gZbScAP0cVBjTXPsZSjZaMuUINSbBzaW4GoWO6YB2tYc0tsAGUFkPISV4xPbIpahnytZ
         zyXkF3BdXK7ma9zdKYDJAn9w7aQ2Y6slaX4IZXxsd0/OTun3Y5snuWmt7nyPhnRhWFmi
         2s4lKfwsbkPOlLighLxRNzpygU9yZ+0+C6Sm1Cjs4gI+jYXFnc+xzn0DpN4D6096Qusl
         OMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn2AcuBT0fvJkrgHTd2c/hoZ5Zj/kmgAMB/+z6YAX20=;
        b=d6iz/4ViCw1XRSbGtaPODFUtP3YWr6QddcqDsaQDZoQRHBlz7hI49fo2v8youZslGi
         cMDQHoZuyBG/cYVwC7DDCdh5cm6UPnttugQPdcJNow3oXC8vCd8ahVrGFOeIKNcGXTrk
         vc1TO7l7ywHk/gSlVhDaQBYKE0iTkNxr33gqaV0RwD+HJjXVRJErwEfi4AcFAipYo/6G
         Jt2yJU5R9JTJE6DGLg57zQb3MESXvfAcGntjF9JWmV7fHX8A3kEuFsvFiT8WY3a4tJ1R
         KNt5vNoyvFytrk5cJxSSB6N9AsZf+vhA4RGWiRp9397TDFrPHAGZgw2DsZmQFRNtGwGH
         HCwQ==
X-Gm-Message-State: AFqh2kqm690WOsGd+9je8wFSJ4r9+jHO4gZxzN4TbzoH8lkHvGdyL1R1
        Z8Gf7iBQ9e1FDmwJNnrfEpY=
X-Google-Smtp-Source: AMrXdXv/EdPX34pA5zO0RTZuyu1n6F4/TQCx3YkCTc9rmvcyVe4fHb7p9n7LK9vx+26KcpLsrVhXVg==
X-Received: by 2002:a17:903:2605:b0:194:799b:858 with SMTP id jd5-20020a170903260500b00194799b0858mr492364plb.10.1673631160327;
        Fri, 13 Jan 2023 09:32:40 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2e4e:fba:501b:3a8c])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b0019276616eb0sm14457459plb.83.2023.01.13.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:32:39 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 13 Jan 2023 09:32:38 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 2/4] zsmalloc: skip chain size calculation for pow_of_2
 classes
Message-ID: <Y8GVtrmG1C04c0gA@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <20230109033838.2779902-3-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-3-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:38:36PM +0900, Sergey Senozhatsky wrote:
> If a class size is power of 2 then it wastes no memory
> and the best configuration is 1 physical page per-zspage.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
