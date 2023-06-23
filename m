Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00D73B674
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFWLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFWLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:44:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96111997
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:44:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-311167ba376so564057f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687520646; x=1690112646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3rB+dgkrEcwRWpwe+fMVe50xF5rM3gNf2XNcEl+xLg=;
        b=sPbm0NNP5Ah7KUY+4kDWWMF7XKj08Ies72DWy5JYo9RwMAQ51qWM0Q6Yj06T63RItH
         KTF3APChAZEPbWdGYh2mDLSnkvlpTa5nzJyywaLdW3qz+0EhXYN8CU+lG7B+4nraHAo2
         h4lC7Sa/+r6cxQvtowya4uQuCJsAa6KgTpv0ikmhhm40DYXlc1aunuF6xgw4AJze3z5d
         Ou4b8s/C3Cvx/rltP6DHT4KVLkR9KrJqe7eUH+LYdAJlLIZBfUXsPKZN4cek6HBFLxMN
         AB/+mupDeCiRjVLpgUoe0AYkDrNVzOUkTPan4IF/AYaNRSVMdd9pUOQkwGBfl9GAtH+9
         TaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687520646; x=1690112646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3rB+dgkrEcwRWpwe+fMVe50xF5rM3gNf2XNcEl+xLg=;
        b=dNlmyTMezGL06Qssc0SQqlMx0u0i6udPd6/4XxfzKOVpyFy2S62hnLe2EhSNNCgIln
         o8mvppld8RZvROkKPa+bDxw3I4/UoxlbnpqYPuCnYQtLr7vYd8HYEJNDc5LkejCxaEWC
         O54gCy+IhXD9KV6lE05aXTWGJT9W3HRMyOuTqr0eUDcytFm6MG0YHP1Thy8xy6Einse7
         +I12iLxcj4W9pBtSWBGb/siS2ZsjMm5OW8fb3pG1jXQhuwiWYzGZaeAb1islRRed94I1
         pKFrl6l38T39MzHvh2PuojY1xldT8TXZJo25qkdNaf/5L5dgLuF9MIRsm2lYjtUUkyFt
         Kq6w==
X-Gm-Message-State: AC+VfDyNBNjG8DmQq3H9Xx4j0tYF0WL1qxYVZsTQ3nW5nKAU8JwpIplk
        MYAzhwLP6UkUmfqPPmysQOoox1vTSTIudI4Qm8s=
X-Google-Smtp-Source: ACHHUZ4nYGYbiJkV1RjU5mrRbFBYVjmQ2K6ko5uoSyccZGSlyJrAl7f8/YrN7xgyrRr2f7+zxCQN+g==
X-Received: by 2002:a5d:6148:0:b0:30f:c029:7538 with SMTP id y8-20020a5d6148000000b0030fc0297538mr16051568wrt.46.1687520646210;
        Fri, 23 Jun 2023 04:44:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b0030ada01ca78sm9372521wrj.10.2023.06.23.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:44:04 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:44:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sai Krishna Gajula <saikrishnag@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
Message-ID: <3894dd38-377b-4691-907b-ec3d47fddffd@kadam.mountain>
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
 <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
 <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:28:19AM +0000, Sai Krishna Gajula wrote:
> > This probe function is super weird how it returns success on the failure path.
> > One concern, I had initially was that if anything returns -EPROBE_DEFER then
> > we cannot recover.  That's not possible in the current code, but it makes me
> > itch...  But here is a different crash.
> > 
> 
> In few circumstances, the PTP device is probed before the AF device in
> the driver. In such instance, -EPROBE_DEFER is used.
> -- EDEFER_PROBE is useful when probe order changes. Ex: AF driver probes before PTP.
> 

You're describing how -EPROBE_DEFER is *supposed* to work.  But that's
not what this driver does.

If the AF driver is probed before the PTP driver then ptp_probe() should
return -EPROBE_DEFER and that would allow the kernel to automatically
retry ptp_probe() later.  But instead of that, ptp_probe() returns
success.  So I guess the user would have to manually rmmod it and insmod
it again?  So, what I'm saying I don't understand why we can't do this
in the normal way.

The other thing I'm saying is that the weird return success on error
stuff hasn't been tested or we would have discovered the crash through
testing.

regards,
dan carpenter

