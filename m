Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6C72F912
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbjFNJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243982AbjFNJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:27:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9EA170E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30fc6b513afso2034878f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686734849; x=1689326849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtefXDjYklud7abCsC+WgTuAbpHOK06ISGHObSNNODA=;
        b=yrfI34Q6GvN+FjN0tBMhRhIOeZ+VqlZlmPBIeLwUQwYA9symwc6XeIfHRDvjxLjG6V
         mWI92FC7g4Iy+mbS+/EKtIv6gpw4bdc2QDKWvI32GRRv8eRIejwNFcMqxmc54nmtzfOS
         vf3+qYecBp+aVBHQXycTqZiXDwW3Cs5cTChM//GSlmbcUKVdqWeA+3LPSuydIIMrsEB+
         q1rV5ytMHmwhHX17niRkrt4lA0p7by3+yJTr4CpUmls7/tfRMGt4+9e4kjWUuWR080Qf
         P3ot1hflAhk4tZAoWorHdR08BCgd3svaC365uWcMicY8oIDQ/xlHHpPBO6Z0nBwgzCNt
         WmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734849; x=1689326849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtefXDjYklud7abCsC+WgTuAbpHOK06ISGHObSNNODA=;
        b=j8C+rfHjkHm3BEhhlpjJiPWqi4CPJ8E0n0lnaGj99+bYmH3ANPG8WDsetAFQxcluNR
         Sg0OWv9bRJiFAxnN7k/4jjDyVRiKV3GACnKcxRfrlgnk0/EN8Rrdijv3mwdcYE1z+ody
         Qy3Fp/JZ4024rvEv1UqdVG9nr+h+veokq4m9Yn+m5vWftbNnHD7RhDEruFHGcNH6V3mS
         DxJlXp5TEoZn8pPjM9UGSWbEIKPNnI7lSDttwPfzSusrwvu9xbgJWwwuZ6ZR0TkeAPwC
         l8CzzpatebSEi88Ut3ZCWwP4gEs+OMYgt1OcEWXcu4FbQIdM4JsT14NvZnJqneiXrSGA
         aJnA==
X-Gm-Message-State: AC+VfDwVkxuP7EJTMZBEQBwqb7P4tJYIfkkB+trWgh6toBIjmlH1nNRZ
        Cu5ht7FStogkgOifH5BLLMnIpw==
X-Google-Smtp-Source: ACHHUZ7GlBUfe4DA2qBjSg64mcltE0M9LgJWODvo3Av0ztoxCP/DZKdZxYp0GD/Cv/+mNbbxd4YpFg==
X-Received: by 2002:adf:e54c:0:b0:30f:bd48:6828 with SMTP id z12-20020adfe54c000000b0030fbd486828mr7876719wrm.31.1686734849068;
        Wed, 14 Jun 2023 02:27:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s14-20020adfeb0e000000b0030ae53550f5sm17681103wrn.51.2023.06.14.02.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 02:27:28 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:27:27 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        vadfed@meta.com, jonathan.lemon@gmail.com, pabeni@redhat.com,
        corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 01/10] dpll: documentation on DPLL subsystem
 interface
Message-ID: <ZImH/6GzGdydC3U3@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
 <20230612154329.7bd2d52f@kernel.org>
 <ZIg8/0UJB9Lbyx2D@nanopsycho>
 <20230613093801.735cd341@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613093801.735cd341@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jun 13, 2023 at 06:38:01PM CEST, kuba@kernel.org wrote:
>On Tue, 13 Jun 2023 11:55:11 +0200 Jiri Pirko wrote:
>> >> +``'pin': [{
>> >> + {'clock-id': 282574471561216,
>> >> +  'module-name': 'ice',
>> >> +  'pin-dpll-caps': 4,
>> >> +  'pin-id': 13,
>> >> +  'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
>> >> +                 {'pin-id': 3, 'pin-state': 'disconnected'},
>> >> +                 {'id': 0, 'pin-direction': 'input'},
>> >> +                 {'id': 1, 'pin-direction': 'input'}],
>> >> +  'pin-type': 'synce-eth-port'}
>> >> +}]``  
>> >
>> >It seems like pin-parent is overloaded, can we split it into two
>> >different nests?  
>> 
>> Yeah, we had it as two and converged to this one. The thing is, the rest
>> of the attrs are the same for both parent pin and parent device. I link
>> it this way a bit better. No strong feeling.
>
>Do you mean the same attribute enum / "space" / "set"?

Yeah, that is my understanding. Arkadiusz, could you please clarify?


>In the example above the attributes present don't seem to overlap.
>For user space its an extra if to sift thru the objects under
>pin-parent.
>
>> >Also sounds like setting pin attrs and pin-parent attrs should be
>> >different commands.  
>> 
>> Could be, but what't the benefit? Also, you are not configuring
>> pin-parent. You are configuring pin:pin-parent tuple. Basically the pin
>> configuration as a child. So this is mainly config of the pin itsest
>> Therefore does not really make sense to me to split to two comments.
>
>Clarity of the API. If muxing everything thru few calls was the goal
>we should also have very few members in struct dpll_pin_ops, and we
>don't.

How the the internal kernel api related to the uapi? I mean, it's quite
common to have 1:N relationsip between cmd and op. I have to be missing
your point. Could you be more specific please?

Current code presents PIN_SET command with accepts structured set of
attribute to be set. The core-driver api is pretty clear. Squashing to
a single op would be disaster. Having one command per attr looks like an
overkill without any real benefit. How exactly do you propose to change
this?
