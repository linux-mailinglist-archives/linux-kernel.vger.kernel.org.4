Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46030633F95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiKVO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiKVO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0E73436
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669128878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQhBdYbvNkP0eP2nbbeySm3YiluuN527Uf5Ie/DRhVQ=;
        b=QG6xLMfhyd4dAEVvBbDIEg1B8Bi4oAOTUej858YUXcNpemQl3mqDFUhEY9J2zofFX3rw9N
        4UsHQfnc/fBvFMNU9HiI0jra/8cAfM6GUsRBpinZCGByz2oQJ+4wR5qx4p6A0VxCGY5KHs
        LkPU9Pqk+hLRuGTVWhoKblXZBzKb1n8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-3MX_ImKKMEWUWTDwdConQA-1; Tue, 22 Nov 2022 09:54:36 -0500
X-MC-Unique: 3MX_ImKKMEWUWTDwdConQA-1
Received: by mail-wm1-f71.google.com with SMTP id i133-20020a1c3b8b000000b003cffc0a69afso8705744wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQhBdYbvNkP0eP2nbbeySm3YiluuN527Uf5Ie/DRhVQ=;
        b=5eQUU4DuNPskkUFSBXWVL/PMiO5U1petvM7fqTZxkstrrT912zSdcnWkAJeUVbqepT
         HUKmdvMlT1+Q1VIpWAiwav8Mltgf1nXDo4GinIg5Efz9tHg4rMS0YLBS1Bkh1pejksPp
         Iu2ppXcQbE30oxjdtWqIeN3/HUw6xpVGJLU/uclI0nt1kjvSehJvAWxoesOIVDt0aA6t
         oUij7yLB3uXLFw0dg11YUjvnEeXTNZq4kpHYrlft46rtU6vFSwb/d95bhD1qCA4V+cg+
         a+za0IcXNoYmQLmpXp+/9eTMOIaMfB+A9f3TQcAT9fyn/Bh9uJmG/fxFWi99ZqpTX4Dn
         GfLg==
X-Gm-Message-State: ANoB5pl91AmMVemNUVVRs2Ack/x6Sn7n6HWUkzbu4JZfiFx/y/fh2mFG
        dyKHgGkPmqqekZe4ESXLoQFItUKqjg0u24m47lL4Tfmp6w36AgH1hVwk2EuNxSyUtw98u7hRBZS
        HCoOeyvzKk+RQGukCpSNEsqMm
X-Received: by 2002:adf:fc50:0:b0:241:d2de:b11e with SMTP id e16-20020adffc50000000b00241d2deb11emr6798782wrs.347.1669128875411;
        Tue, 22 Nov 2022 06:54:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4XCHIf/w2Z/vFBbJK7QGJPB/tUZZolPFh+8Q0cfmi9UiEJuPJsq20c6J+DsEmyTz3Q+jlxfA==
X-Received: by 2002:adf:fc50:0:b0:241:d2de:b11e with SMTP id e16-20020adffc50000000b00241d2deb11emr6798767wrs.347.1669128875215;
        Tue, 22 Nov 2022 06:54:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm3292531wms.0.2022.11.22.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:54:34 -0800 (PST)
Message-ID: <927643d6c2e5f681847fd2023ee2dab371ecba12.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 2/3] net: mscc: ocelot: remove unnecessary
 exposure of stats structures
From:   Paolo Abeni <pabeni@redhat.com>
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Tue, 22 Nov 2022 15:54:33 +0100
In-Reply-To: <20221119231406.3167852-3-colin.foster@in-advantage.com>
References: <20221119231406.3167852-1-colin.foster@in-advantage.com>
         <20221119231406.3167852-3-colin.foster@in-advantage.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-11-19 at 15:14 -0800, Colin Foster wrote:
> Since commit 4d1d157fb6a4 ("net: mscc: ocelot: share the common stat
> definitions between all drivers") there is no longer a need to share the
> stats structures to the world. Relocate these definitions to inside
> ocelot_stats.c instead of a global include header.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>

I think it's preferable to keep the moved code verbatim as-is instead
of additionally fixing the checkpatch warning in the same patch.

The mentioned cleanup could be a follow-up patch - togethar with the
trailing empty line removal.

Cheers,

Paolo

