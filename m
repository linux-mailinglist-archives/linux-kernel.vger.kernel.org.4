Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD96A08C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjBWMmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjBWMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672C54A25
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677156114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6Cqo7+PwcBu/zopx2C+yPrKMjZcg1DLK1AXw2nlKyc=;
        b=a6GIX95aON4qxsNn24h1TixsoxqW62qO3FH+nH+wDwqqplInDpcF6wvXIQVevUyHLwjXLQ
        gTAFDV7wnPHtQsEjkJ0qdKPgFnjQM/+/Lr9q3kQa2wdW6NSblIvkIIE6O2UX8LnznbJAu4
        LkhSo+QMEU4AZl3fAy4+Hreousf7Va0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-nrWhN8IvO5ulfAy-DoL2fg-1; Thu, 23 Feb 2023 07:41:53 -0500
X-MC-Unique: nrWhN8IvO5ulfAy-DoL2fg-1
Received: by mail-qt1-f200.google.com with SMTP id g10-20020ac8070a000000b003b849aa2cd6so4984028qth.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677156113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6Cqo7+PwcBu/zopx2C+yPrKMjZcg1DLK1AXw2nlKyc=;
        b=iURmd5Q+dZYLt/+8/cJAHSbELthfGdD4YEx5Mwt2HBJQ7+unojD8N1vba0H/dG0RDF
         mprzKLwsmxl1D4E4IhM/KtHPRIqOBAsI9y+pp/yOt8o9i9/pg5g65k4/xn812CLzmzB3
         qteWG3X2IGTgxVuYQoHDoiBDdiwM9zC3L0UXncQE5Rp3GkRmowvqfsOhzUU9K2AWcwtR
         NqYIsvI2WpHTpyUKIEihkmHqrYGeP7zbXHcZ1KBK8qqxL2Zoqy7LPtKY0766Lfaubf7/
         qewsI0hVe2JijST3YWNKOCnxGtadnL24fwIH9DS1wlsoV5TsP9wKFs+T6GP8y3s/mfrs
         xJOw==
X-Gm-Message-State: AO0yUKUUG3BSlUb9Jz01hyX7crsw8+RNFC8aJ5ygzTS/Pg9/wIA7K/0y
        4L7G0nT5BDg5iZIK1n9Unv0jfLGWva9lhIu9hMtfBVGTugFm2UKt8PgXlJ/UttlSCKFzuGRCVFw
        sJjW6740Ig+CRdhqlq8j1j+nf
X-Received: by 2002:ac8:5995:0:b0:3bd:1c0f:74f3 with SMTP id e21-20020ac85995000000b003bd1c0f74f3mr22366175qte.2.1677156113148;
        Thu, 23 Feb 2023 04:41:53 -0800 (PST)
X-Google-Smtp-Source: AK7set+3uyz3sDwb9LtJ6nGo8zOM1FUmyOWM05R8WPDJXKNnIAmw/Eq4Z7znxYxIlsfhpY9MqMwlIA==
X-Received: by 2002:ac8:5995:0:b0:3bd:1c0f:74f3 with SMTP id e21-20020ac85995000000b003bd1c0f74f3mr22366144qte.2.1677156112856;
        Thu, 23 Feb 2023 04:41:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id ca26-20020a05622a1f1a00b003b62e8b77e7sm6158821qtb.68.2023.02.23.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:41:52 -0800 (PST)
Message-ID: <633f202d784a8c67fb846336941ef3e22877d1c7.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/1] net: openvswitch: Use on stack
 sw_flow_key in ovs_packet_cmd_execute
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eddy Tao <taoyuan_eddy@hotmail.com>, netdev@vger.kernel.org
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 23 Feb 2023 13:41:49 +0100
In-Reply-To: <OS3P286MB22957CD400DAAAB7786FEF96F5AB9@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB229572718C0B4E7229710062F5AB9@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
         <OS3P286MB22957CD400DAAAB7786FEF96F5AB9@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-23 at 20:24 +0800, Eddy Tao wrote:
> Sorry, there is a typo in the mail, i will resend shortly,

please, don't do that.

# Form letter - net-next is closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Mar 6th.

RFC patches sent for review only are obviously welcome at any time.

