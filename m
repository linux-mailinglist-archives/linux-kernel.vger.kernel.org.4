Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9841C6DAA70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbjDGIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbjDGIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:48:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ACBA5FB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:48:31 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54e40113cf3so4256827b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680857311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGThRYH6H6dxTadmeKE2mcrgAteozA7JJr+udI4tFcI=;
        b=X+SsFQeCNvJZf8a301ffJO7aUt1V0eF+QFcztc3bsy7CQIgHE+b977WsQ8zDChVlyF
         ySpWUsJqb5vQ3UjM7A4L9ml411W9TrkwJYqQ1zJmVD5ZLVvmE/5GZRIzfHpJM79NulNa
         YzZ/4XWfx9gGKn5qNhPT7FjUfnHU1bYcfi1F5xwYO0opzwCfQqkgCx92wfU0CV45V0x3
         dprK1ZBrN9w7MqyWv2AxyBuZiyiligZRy6U3YLe3pkLHzg6a5M/AyrY3XLljYSiBlgXm
         O7JwoegEnhcUqOhaaWYl6V2fe6eS/coZY25P8pgO2x2x25AH6vgZUKUg9ins9hiNjmFA
         ZCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGThRYH6H6dxTadmeKE2mcrgAteozA7JJr+udI4tFcI=;
        b=hiSzX3V+bo/kRvGpxg7c/MOw3K6O/Ru0Ymjf4AK2QjEZ69N+T5lV0D8YPko5p5mBES
         34ZBXcdzs8RiMr02vadlI4UVKZio2B29TpCjyfdv73VBSbVWWaLcrx85+5b9uJXy68cB
         sgqhoE9UW2pYDLlUwDoZX1RKAqCNUGtRF2GnCLt4wuuKOFy1PhFvMKbwcF4012tcgMDl
         n7YaGliCwJzXFmuZu5Oud8q3c1hc3gNaSLY2DcB+itQM4nyaA8GfcaPTavh5vsJ/Ysuy
         1h60X6311lQajjll4+JiBrSDD6fjkeV7x/U8ArZ4Eo2xsoNEwlkWd+SMvR6hNotigrt7
         YTvg==
X-Gm-Message-State: AAQBX9ejLy9dFSLB3yJH2nHN+yv2Tw/xpxwIaPBsgrnNYjsHUfBFxtt4
        xFmhdCH4hzfJDP+ju3Dcm2VMbCr/Gtq8mkXrenkigLFURVA2VZsTsTgLfw==
X-Google-Smtp-Source: AKy350buomdlTAS7MdSVy7YoDTBvicUiGKlGGDraOV6qjRskJNBC93da5hwrPO4b4+67HTfuYzh8/CTRnMcPDrBUYSw=
X-Received: by 2002:a81:4004:0:b0:545:1d7f:acbf with SMTP id
 l4-20020a814004000000b005451d7facbfmr673596ywn.10.1680857309862; Fri, 07 Apr
 2023 01:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug>
In-Reply-To: <ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 7 Apr 2023 10:48:18 +0200
Message-ID: <CANn89i++9qYyhbh30RPqabeTbBbUHdAv+0YP0Z01pbMm1+nt5A@mail.gmail.com>
Subject: Re: [PATCH net v3] net: openvswitch: fix race on port output
To:     Felix Huettner <felix.huettner@mail.schwarz>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        pshelar@ovn.org, davem@davemloft.net, luca.czesla@mail.schwarz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 9:53=E2=80=AFAM Felix Huettner
<felix.huettner@mail.schwarz> wrote:
>
> assume the following setup on a single machine:
> 1. An openvswitch instance with one bridge and default flows
> 2. two network namespaces "server" and "client"
> 3. two ovs interfaces "server" and "client" on the bridge
> 4. for each ovs interface a veth pair with a matching name and 32 rx and
>    tx queues
> 5. move the ends of the veth pairs to the respective network namespaces
> 6. assign ip addresses to each of the veth ends in the namespaces (needs
>    to be the same subnet)
> 7. start some http server on the server network namespace
> 8. test if a client in the client namespace can reach the http server
>
> when following the actions below the host has a chance of getting a cpu
> stuck in a infinite loop:
> 1. send a large amount of parallel requests to the http server (around
>    3000 curls should work)
> 2. in parallel delete the network namespace (do not delete interfaces or
>    stop the server, just kill the namespace)
>
> there is a low chance that this will cause the below kernel cpu stuck
> message. If this does not happen just retry.
> Below there is also the output of bpftrace for the functions mentioned
> in the output.
>
...
Reviewed-by: Eric Dumazet <edumazet@google.com>
