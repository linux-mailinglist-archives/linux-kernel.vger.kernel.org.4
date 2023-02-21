Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B469E045
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjBUMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjBUMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4D5588
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676982201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNXFmKIe+V0KQQC9g0T60ZJMUB3rW25DANWb62cyY2c=;
        b=aaKnUtxSNgI1z00NFa8DveRm5ULyE5ncxpKu1I5P/SsIHCzW/CPxRoN4TbQgFPoSSJCvOl
        marjhll5p6YChlD+/2LOtrPNpxkND/a/x4vtazY4A84atodIpCuyXXsr+dpTcJJCW3MxOQ
        F5eo/EJ/EStTT2TpUr4Fhno3LlbUr1w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-dbGU-kjJPje-mODf4E24xA-1; Tue, 21 Feb 2023 07:17:14 -0500
X-MC-Unique: dbGU-kjJPje-mODf4E24xA-1
Received: by mail-wr1-f69.google.com with SMTP id n14-20020a5d67ce000000b002bfc2f61048so1024794wrw.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676981833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNXFmKIe+V0KQQC9g0T60ZJMUB3rW25DANWb62cyY2c=;
        b=hyBhrZnbRpgjuMVUkkP1/RZvDbYt3XEiY3ZelWC4lzd8TVIFdnosaR5rfbqxK+OxZF
         U23VXb53/RWOTycWr2Xm0WdALoSF0BDdqbPKT8RB1iw6g8ACBYaaSVd6QTqkKhN67/dw
         +5m2DkdcXGVYfnanAvz+7F3GM5iuLmcDRtTcrBETd1gBEMUsS4YMvo8HHH7H3vc2diTr
         y0qNjxqiiTkI4zaEYalNk0socrG46XF8dGKTSreFNb/9R5wIgWGAmAW+nnD3CqjGzx3Z
         IbDMEkKyfblVdFkDk9ULotG2E2mxGgPY8RcnaWLwwTt0q4onlydvw8lxdwUuFjxjVMh2
         +GXw==
X-Gm-Message-State: AO0yUKXwMO5xCABJCqatW8vwOhGzbFZviqr4ATiwXsJhV2ethtwVlkqc
        c45ab8aa0aK9DLLs2BmkAfJPTEycNJFcp3/yM2sj8AVnKThck9jT9HnysBWFPRRRcJZ50cN6/vf
        u/tvuXZzDE27DcelzPwws5iGT
X-Received: by 2002:a5d:4c85:0:b0:2c6:eaaa:ac1f with SMTP id z5-20020a5d4c85000000b002c6eaaaac1fmr2676000wrs.3.1676981833140;
        Tue, 21 Feb 2023 04:17:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/lVTYGNh4HaCwtBDAJNc3LFnn0IQ5vN5n09FC9/X7Gp9R15fLBQbwKliTEdMyWa2pssfAD7A==
X-Received: by 2002:a5d:4c85:0:b0:2c6:eaaa:ac1f with SMTP id z5-20020a5d4c85000000b002c6eaaaac1fmr2675985wrs.3.1676981832813;
        Tue, 21 Feb 2023 04:17:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002c560e6ea57sm4181149wrs.47.2023.02.21.04.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:17:12 -0800 (PST)
Message-ID: <5ae9c011b1b818badfd1291823fef812e9748077.camel@redhat.com>
Subject: Re: [PATCH net-next] net: phy: update obsolete comment about
 PHY_STARTING
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Feb 2023 13:17:10 +0100
In-Reply-To: <20230221105711.39364-1-wsa+renesas@sang-engineering.com>
References: <20230221105711.39364-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-21 at 11:57 +0100, Wolfram Sang wrote:
> Commit 899a3cbbf77a ("net: phy: remove states PHY_STARTING and
> PHY_PENDING") missed to update a comment in phy_probe. Remove
> superfluous "Description:" prefix while we are here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

# Form letter - net-next is closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Mar 6th.

RFC patches sent for review only are obviously welcome at any time.

