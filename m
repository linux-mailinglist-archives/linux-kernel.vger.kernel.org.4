Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF93C613B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiJaQnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJaQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:42:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0162AE0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:42:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1057202pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6g3n64WcsjZVHXYVU68pvzZtWqYwSldKDwzmXxyYkJA=;
        b=fA9yAllLtZLJNw2JbRf/dS5uD+i/e+/FarZbYdku20l2kVtuORZy/jQ56FKKwCj82N
         mDJXDXOJCv5Qek98ZrbkDjMgJFpzZPaPkCSs3ndmjDJloEcpNIiTFaeZ78sCspOs0PDf
         +r+zhN5R933+znf6VxuGJCx8ioJiN+53oLpNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g3n64WcsjZVHXYVU68pvzZtWqYwSldKDwzmXxyYkJA=;
        b=BO/xLfCrPzQuPsY9XVxkl7DbAmIJTiAuvyLBAJ1v1654aOrIl2/bhf/R6yB+/AENjX
         ly982dxPDay3s4INRYOQ8dgsTPPF1MJu4EERuKfZIIwaFMn2aMJ7kdpHtrj0NuSiTwHC
         /nJ63ebydvcTuuUWduUJf3wj5PwUhNqdFrtxbuxCXHQVgZYiAa0vAYOOejIFXVghzquO
         ZQfBq+3y/0S4TJTYAAVcIsjs9o7EAf94scIwc+gmWko2ehwwSvSV+2vAkMkz3CCupx9L
         9kJ8vIqpzra4FkJpiYZygbLdhYgZolReCmPSfnkt6oFAAQ0+TveOJBLe27XUTMBPpXq9
         af2Q==
X-Gm-Message-State: ACrzQf2cFXem7N299oIkjNE7nOCLBZz7bQ3lK4QJMuQzbIneQ6J7MwZn
        IqDwlWrbLg9aM64/ix6HVrILcw==
X-Google-Smtp-Source: AMsMyM6tta40nq8js1+lXIr/1axqWGfpbLfIlkZWbJY2upYOJ/Thil/osd9WGMNz18e1zYsamRJ6JQ==
X-Received: by 2002:a17:902:f602:b0:178:9818:48a4 with SMTP id n2-20020a170902f60200b00178981848a4mr15116183plg.148.1667234576715;
        Mon, 31 Oct 2022 09:42:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cf9d:6561:637d:2194])
        by smtp.gmail.com with ESMTPSA id l20-20020a170902e2d400b0018689e2c9dfsm4654744plc.153.2022.10.31.09.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:42:56 -0700 (PDT)
Date:   Mon, 31 Oct 2022 09:42:54 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] platform/chrome: cros_ec_lpc: Move mec_init/destroy
 to device probe/remove
Message-ID: <Y1/7DgHiWLqbrDIi@google.com>
References: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
 <Y19VXaB1531V64EI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y19VXaB1531V64EI@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:55:57PM +0800, Tzung-Bi Shih wrote:
> There are 2 more cros_ec_lpc_mec_destroy()s need to be removed [2][3] though.
> 
> [2]: https://elixir.bootlin.com/linux/v6.0/source/drivers/platform/chrome/cros_ec_lpc.c#L596
> [3]: https://elixir.bootlin.com/linux/v6.0/source/drivers/platform/chrome/cros_ec_lpc.c#L606

Your links / line numbers don't make sense, but I see your point. That
was a bad oversight on my part, sorry.

I see you're probably dropping the destroy() function, so I guess I'll
send v2 without this problem.

Brian
