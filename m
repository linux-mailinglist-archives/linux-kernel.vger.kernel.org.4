Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303916F444B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjEBMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjEBMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:52:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E15BBD
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:52:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f18335a870so22640015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683031955; x=1685623955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5nhvdWhebkMYO4GW1JxCEEWKCb3+y/3CByFzV8Cg/c=;
        b=CxaCtcuzOTNy7f/1wJAHyAIhOYhUOJ0mbsaDVqtncXXmwAROV60TU3lViUssIFHZu2
         Y31y022xEnfx8eiUwsx+QVJP1HHcEr9E7MF9OAEtz+3wjnUoLQ8r4mfsTctwf+iYAq9g
         1EfUl5kzbDGIwguNiog2N1myfzcyrSokUyTkrb+YK3DlXmdsbVNoSgMhYenDhugsIG/7
         ECjfMJHoaogu02mSajg8uaGajCLr/UXPgoopLCfD/CYWJNN871od1JuyqDKPy3R0zXwS
         YybhLrnyrZ4wNSzKFfQfvNX3SwtEMq2Zy4VnJXLnukb8qhR3NnI5b9oRKSgPRb8Xuq8p
         qegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031955; x=1685623955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5nhvdWhebkMYO4GW1JxCEEWKCb3+y/3CByFzV8Cg/c=;
        b=RNACA6wK0Z6lLMdwLmFT5Fk8Exn3yJqpQByiqVHDX5K3wBWElM3myfPMCaVC0Stcq+
         yM/jqKSvpYmyrySmkY4oWGLcbIFOa+MZ54r3lyCDkHzWXePizobM5GMb5gY506+XRXCz
         XQzHBMnEidYfLF8d3Jedpo3M50LcWs+csE39D44l9QBIZjL8BQo2YmoZUrTGE6iqPPXd
         EOd99oXVMeC+2WfdjDVkJuOY50dfHkyliEMWOOmK2jqBhicI4zjLiJ4kYNSM8IFWbk/L
         tSap+KoDYRGzz71p7ALjfZJI0tDbh3Fo0/lmaH1OgVrcBAIMk1v89pxwMfmepNZCKnUA
         65ww==
X-Gm-Message-State: AC+VfDzD9qnfMSE2X1gLK6yDvQVErYxa7QppR0ZKnSlNzCboRkCISeOM
        11SyIYK+OHBSjqZVlB4MpMbG+3okjlGH/iei7h8=
X-Google-Smtp-Source: ACHHUZ6l8mKcdy9L6W76xeUt3EbwO1UlAd+EWeiolYIzQNmUagEuLN6MiyY6NL3j25PcHAYCehExSw==
X-Received: by 2002:a05:600c:ac8:b0:3f1:72f8:6a92 with SMTP id c8-20020a05600c0ac800b003f172f86a92mr11860067wmr.20.1683031954701;
        Tue, 02 May 2023 05:52:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003f0a6a1f969sm39293362wmo.46.2023.05.02.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:52:33 -0700 (PDT)
Date:   Tue, 2 May 2023 15:52:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jinhong Zhu <jinhongzhu@hust.edu.cn>
Cc:     martin.petersen@oracle.com, GR-QLogic-Storage-Upstream@marvell.com,
        error27@gmail.com, jejb@linux.ibm.com, jhasan@marvell.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        skashyap@marvell.com
Subject: Re: Re: [PATCH] qedf: Fix NULL dereference in error handling
Message-ID: <e5d627aa-5bb4-4b24-bdb2-6cf26195d431@kili.mountain>
References: <yq1fs8ok4v9.fsf@ca-mkp.ca.oracle.com>
 <20230425125823.2325-1-jinhongzhu@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425125823.2325-1-jinhongzhu@hust.edu.cn>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:58:23PM +0800, Jinhong Zhu wrote:
> >> Fixes: 09e062ce83cb ("qedf: Fix NULL dereference in error handling")
> 
> >This commit does not appear to exist in Linus' tree.
> 
> Sorry for the wrong fixes tag.
> 
> This is the correct one.
> 
> Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")

You need to send a v2 patch.  I have written a blog about this process.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

