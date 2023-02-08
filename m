Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F368F118
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBHOoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjBHOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:44:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF54ABE0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:44:39 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id sa10so21341331ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDy3NocjvArraEl6AxQ9hnOhL9P3eliaBBIoj5WWDtA=;
        b=kF0jUotzr9gBu+jEIkoI/F7w4YiCfzqXRdN/8fn4bCOSt8goCY/ik/prMDyw674nBw
         SlbS2GoZPuNyz+emC6BUwkt5PEG/uTjuQtH0ngzeo1lRIXsXnRF0Q367q+FiWB5Ys03+
         ooGKrgVj2LrlJK/Z2DeQYaBLnerM3uHG6KkAZyO3KdJv/ylssiM7GtUrdBDw7FpGgphf
         dGn+ek8gXxQLac0wO51KbsBcr3UtILI2qRG3kIBITxH0AcAgzDtbMlo/RCNRx62b0AtC
         iJjfhfuE145jMDPdSt4q25B2NDOIH0fVKtNLEuA3DGuHXHIeaQIb1ISt4RA91nq4t87F
         NMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDy3NocjvArraEl6AxQ9hnOhL9P3eliaBBIoj5WWDtA=;
        b=lukpH1rttjkdWDu7LwOH2GvbOtgTlOQ0uoPsQdFqION4OyERG1i7PF4l0g4rQYqkZp
         Bao2QXWOonVfGzvgdz/8KUHXzYl/W7Hud4joXdgzUAC52SsIYP099sbPR+uBd+K5HMmF
         OkVGkVhXZfRUJfZs6bUWXROJt9FOBKySkI5XN7wcV7K0aP6LfGzINj6/YlIckkVZFo+L
         24k57+c0VRH9J2Pxfw+AwMklumMswSrOYVk+5SxQUhywUgrjzx5eSV7SlHRcLIIKwBVx
         RJaFE0vBIVOOcyrHL0Is1QyfJVBEEQYVHx3woNcF/3aLIBVBfW5Uytx83WSz3gjg8FnO
         hoVg==
X-Gm-Message-State: AO0yUKVHHQqCQGPTFUtg7hqb9lCTt+WBZc6Q3qsfvCqYJFSan7Wzp26/
        i7WxRlMIvDHdE1+pO8DBn0gr9Q==
X-Google-Smtp-Source: AK7set9qYlJ+CisVLCwiWnp8Ar609N7ufxMnaqevfhXepk8ApPMWvdz7gcAS95s+ODrrJoC0GJzA1w==
X-Received: by 2002:a17:906:b853:b0:8ab:4c4:d0f6 with SMTP id ga19-20020a170906b85300b008ab04c4d0f6mr3244759ejb.56.1675867478130;
        Wed, 08 Feb 2023 06:44:38 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id kf15-20020a17090776cf00b0087bdae33badsm8366973ejc.56.2023.02.08.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:44:37 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:44:36 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dev@openvswitch.org, tipc-discussion@lists.sourceforge.net,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 3/3] openvswitch: Use string_is_terminated()
 helper
Message-ID: <Y+O1VJtzhlhRtR0o@nanopsycho>
References: <20230208133153.22528-1-andriy.shevchenko@linux.intel.com>
 <20230208133153.22528-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208133153.22528-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 08, 2023 at 02:31:53PM CET, andriy.shevchenko@linux.intel.com wrote:
>Use string_is_terminated() helper instead of cpecific memchr() call.
>This shows better the intention of the call.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Reviewed-by: Simon Horman <simon.horman@corigine.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
