Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36F73BB6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFWPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFWPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:19:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E7268C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:19:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51be840891dso784122a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687533554; x=1690125554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7eKK3NYw/OZosKXCLsiNWhf+zhDMnVZ3w9TgoZpnvM=;
        b=pufECKMNhHNzLknHPIC3dP0Oi2kgtKveh/tvCIae1JBk8aEl2hgIxP6zVbMt2ojNNG
         M6wOQJkOdAHyQGlOQprGiN7ZndNROlGcHr43PmS/VxAx83A25Njs0VjqIYbCtrHFiZLL
         bbAgmPHAcnMJnBqZIc+/jThJV7657kRiif+YP1vqk+YsQig588X+/yevhli32B5Hpp0I
         sugJRRFkIhM9n4wozD7pkxZzENYZwNlgHZIjzRyRx62ZgGU/XwpooKqqWTO1bjb9y1HO
         dLI+EEkcs4q8FajFm5rZrPUz9iZ5OtAfmltUu0hBKyUCAmgcFAHsgRfAcEYmUOagcuCf
         jxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533554; x=1690125554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7eKK3NYw/OZosKXCLsiNWhf+zhDMnVZ3w9TgoZpnvM=;
        b=bwk2JFgKmftUWRcS2kwhw32cToCJ5HNtsmY1khaQYHVk7O5dsw9xZ7qJUodgeBvn0z
         qNtkuH/6xgCW5OOMUvKEEhBohmCOAt6xdVhJEatz8ZnXGWwY6+wRp6zEMleeO5L1u4a7
         knDEYQ0+vrTUaQEmwQpWpR8hFzcrkg7aAgjuXSgPEg+juAKCFTUg4e6dGhQtSpEqrody
         FG12IktYC5RtEtver4b7bFbzjfcdU0XUd5TBE/lPd1jNP0IHyossUJPPA7UTgZ6W0EsE
         0x/VRFovDlK5Tn0IZj/WsVxxiL7KCBBVszy0Hbf9Oj3NN0OlAQHB1fRQKTs+GFclbn5U
         3TYg==
X-Gm-Message-State: AC+VfDw9DzdmYAA+vdiroVq3phLL6CxA/0rBWGB983AoC5b4B6GUnS1f
        n1iWhUqA6MysN+pNmUAtd7AytQ==
X-Google-Smtp-Source: ACHHUZ6xDfyN1tOEN2NYIoQBlq6pUTkM/ulf1OBBxm30WI7jeWoGeDV0AOfPPrS7ih1GjfWzDkCK7g==
X-Received: by 2002:a05:6402:3da:b0:51a:42b2:cb83 with SMTP id t26-20020a05640203da00b0051a42b2cb83mr10642649edw.42.1687533553669;
        Fri, 23 Jun 2023 08:19:13 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402125800b0051a5177adeasm5305833edw.21.2023.06.23.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:19:12 -0700 (PDT)
Date:   Fri, 23 Jun 2023 17:19:11 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
        pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
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
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJW37ynDxJCwHscN@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Implement common API for clock/DPLL configuration and status reporting.
>The API utilises netlink interface as transport for commands and event
>notifications. This API aim to extend current pin configuration and
>make it flexible and easy to cover special configurations.
>
>Netlink interface is based on ynl spec, it allows use of in-kernel
>tools/net/ynl/cli.py application to control the interface with properly
>formated command and json attribute strings. Here are few command
>examples of how it works with `ice` driver on supported NIC:

I don't understand. The discussion in the RFCv8 thread is still going
on. The things I mentioned there are ignored. Like for example:
1) mode_set op removal
2) odd ice dpll locking scheme (either fix or describe why it is ok -
				that's the unfinished discussion)
3) header file bits squash I suggested. Vadim wrote that it sounds
   reasonable, yet nothing changed

I thought we are past this. Why I have to point the same issues over and
over?
