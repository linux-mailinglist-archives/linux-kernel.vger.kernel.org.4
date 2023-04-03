Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADCF6D3C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjDCEkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCEkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:40:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599328A41;
        Sun,  2 Apr 2023 21:40:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso29184029pjb.2;
        Sun, 02 Apr 2023 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680496811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWa3A9u2SS5Q8YbZBTRIXS8A5TC3Tq3MbIfMqvPdelg=;
        b=le1R8hH/pKR8tqVCfK9mbKFd55WDIQm2WoEb9AQwuIn7tbjj/nz6XQCc/fomw31HcW
         h5gmYvlDhO0UougcctR6CEntD8bYHut/1/9VbqIO0aSk0ZHBJ6lTENzFNBeu2JHGPxH6
         h0OpR6U8zWa30HKnTeCA2Fyt5HF00xBMFPMmvcEegzc3gNv8OHoCqF6QZ6UZNQC67pfD
         ZAWavlCRQeslD5geIrHbL643S/ia7du17wO7HVjsnDPB/7wvTGhmd8hUhYDFc/vpXT/1
         576+ooC0gfY/Jkn8Y8uX0NMl7f5F4lsg+HIkRNvsVtdOolaisVtw5XvUTm/meNZjukAO
         gZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWa3A9u2SS5Q8YbZBTRIXS8A5TC3Tq3MbIfMqvPdelg=;
        b=mzwrPVQF/dfpyCJD8WbF4Cfwl9dPEZ6CcpwMCAQpgK5lCQajrmP7juW60+ns26HZxU
         hp3FFH/z5UgwFFavQzYSjbwpQnxYDnhjizds2eB43aS++V4uf2Xooh+1oJslrzOjMJPj
         CRJl80NTaScxvSCReims6FKWg8YJwiMBqdtfPYLns3BqV5yzt9ZwvfnqrB4J+Gy7xGOM
         C/bdDA2QL4KLYCKgTl4Held9u6LJu6KVTET6vh/oQZxLrvMN05RKpw2z+paeTdbC3OBD
         4KJ0lsLR5mOkmPicx825qUQdWr4DeAFCbcVrDoBjdIPKh9lz1EO6LoMhiEZcshU0+Vms
         cXiQ==
X-Gm-Message-State: AO0yUKVZz7okn9VTwxCM2ZHpNu3cuy3b5QaqPp8AK1/l1Jt5umRWLhNW
        caHeqF1ZR/gPaY4XhMAvOfs=
X-Google-Smtp-Source: AK7set/1AghPsFZdDlr4Rs+W9S+fG6H5YKyWq+SsMMEGMeycdFi2nMOBGxw/wQ7zUEtNtx415Yc3/w==
X-Received: by 2002:a05:6a20:2921:b0:da:c7e:6ec0 with SMTP id t33-20020a056a20292100b000da0c7e6ec0mr29182144pzf.25.1680496810572;
        Sun, 02 Apr 2023 21:40:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9a1d:5e0:d8f3:bc01])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b0062d7fb53652sm5701928pfw.38.2023.04.02.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:40:09 -0700 (PDT)
Date:   Sun, 2 Apr 2023 21:40:06 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     hns@goldelico.com, richard.leitner@linux.dev,
        christophe.jaillet@wanadoo.fr, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v5] Input: tsc2007 - enable cansleep pendown GPIO
Message-ID: <ZCpYplW002Eku7Fl@google.com>
References: <20230328-tsc2007-sleep-v5-1-fc55e76d0ced@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328-tsc2007-sleep-v5-1-fc55e76d0ced@skidata.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:00:14AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> When a hard IRQ is triggered, the soft IRQ, which decides if an actual
> pen down happened, should always be triggered. This enables the usage of
> "can_sleep" GPIO chips as "pen down" GPIO, as the value is not read
> during the hard IRQ anymore. This might be the case if the GPIO chip is
> an expander behind i2c.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

Applied, thank you.

-- 
Dmitry
