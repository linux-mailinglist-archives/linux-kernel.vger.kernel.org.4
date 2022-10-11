Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54E5FAAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJKDIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKDID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:08:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6FE6F57D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:08:02 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e129so11728982pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zE/SAZRvKwpvo+sQ2SpKLefCcbqgv/lP+JIDaJt49mg=;
        b=VERpYEOg8R/IDP6g608boowqU1v4MieSpKV4c4S8u2S2pieyJRqWuF0l6iCtquaneT
         vbvkfet/sFDwc/e41GsoC9mo7Rua7CgKeVBBpmjYzvDAzAUXMorKMFwffOpyk3+ykPTT
         i/2srnC5URup9yQQSCSipJ4BnIOmsiHsj43DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE/SAZRvKwpvo+sQ2SpKLefCcbqgv/lP+JIDaJt49mg=;
        b=fRQKCN7JiWMV21vRPRl6Df88CURU7K73EIv0VcO1NHQVl7ugGgRvqZmIgC/YEoiAFr
         1kMTDPD4xM8tpD7youB0b4Kl+HG26jGvqkP4X6Hyyk+p4RNYyap6JRWAkSJBLI2Jp35q
         OuNSysRkd5T0FnoqWJ+8dnO89QhtOFxwy27zpAnXxq7A+NWOfJQ5vWhrP6lF9YgvUeNS
         i+eS+dzhKFe6JfgJjNZ02lBmdd0m6jIhrapnsNTJ7BbBSV8+Ptluodh/3HBaFTN1NMAX
         7Q1tXSh7c6WwTEZINbAeU0ZOCs/7O+ftYAbbbEcZ3p06V6+KEohSlnBBH0ME08ktzZHL
         f8IQ==
X-Gm-Message-State: ACrzQf36HvoB6lGtR5xSpeTNffK8mHHZ4TrwgzZm56CMdBBGf/6c8uvX
        ekbctR0/KralrsRnxMqzHPaARBMOA/7sMg==
X-Google-Smtp-Source: AMsMyM7Ij+gEDNzhGA6lUtrbz+4Jb1lp5rGXM3n0N1hrOEagwQ4BixpmxrMQIP+hA8/fqo3+WNNSwA==
X-Received: by 2002:a63:fa4f:0:b0:438:e26d:5ec with SMTP id g15-20020a63fa4f000000b00438e26d05ecmr19291967pgk.361.1665457682377;
        Mon, 10 Oct 2022 20:08:02 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e032:7d0d:1b6e:aa9f])
        by smtp.gmail.com with ESMTPSA id a4-20020aa795a4000000b0055de3e207c9sm7626723pfk.35.2022.10.10.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 20:08:01 -0700 (PDT)
Date:   Tue, 11 Oct 2022 12:07:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     yexingchen116@gmail.com
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] vsprintf: replace in_irq() with in_hardirq()
Message-ID: <Y0TeDdI9ncrFnqgr@google.com>
References: <20221011024831.322799-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011024831.322799-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/11 02:48), yexingchen116@gmail.com wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Per 15115830c8875 in_irq() is "obsolete".

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
