Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB25E6E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIVVWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiIVVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:22:34 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48CFEEE98
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:22:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D5DD4580A45;
        Thu, 22 Sep 2022 17:22:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 17:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663881747; x=1663885347; bh=7E8ohZ7amP
        4gmMgu5k2Mte2rYzeIOBzbLxi1Q9hD2zg=; b=GMfVkGZn3p8Dxn9TucP9T3PrS3
        xWyJvvFRO8ZAR/0pZedq8FzHUhAkqg0DPJmy3GXVf2SET56ofTB4HoJUECJhMeM3
        gE6s2XAXb/1AKX8fhABqwNsJE4f39jKdnnbJo8wDy4DVQDgbr4HLFo2s+K3l7XBD
        zkvyXKoDltk4/SK8OOt3SG4HbO2KY2oc/PiJA3a5lXlbpdxRbnKhMjw7k2k0LpvV
        ALRkyyq7zo3Rp0mV/AZSIgoFjUOcAs60jGfP1NBusPlZE9f+d6mvdubYDlUOEPWg
        d0nwIayIJDoWWFlDMZuswiPLysgcw887Ms2xoh9tFpYtJn98nFCB9FSzafcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663881747; x=1663885347; bh=7E8ohZ7amP4gmMgu5k2Mte2rYzeI
        OBzbLxi1Q9hD2zg=; b=LmBHiD21tAxTykxG34ksZtjWpvHgfbnWZGim2j/5TypW
        SGK25hrcFGVwhrm/K8KVoLk4hDCjV/lc2jJU5ema1Msaxu5wGXaL/GvNljF9mOY7
        dGygsEN6QbChnQ2iLgJOUfGJgdExYccts6Tk6dzJAmX1EZxpczF1JHhdNGDSpY8+
        p+yulxajHiUIBeh7LLuivK0hOQlveT94gPL1QXd9BptpPDWDpnCTvtS6PBuffIOI
        MoPurj8uWdwFey+uoMgsBvA4CyK2wFWPUMEhsqmfG7RnBXT0CUhNu4ua/21eDn9o
        rGUefThDtbWlrJrtvuKI2kUA3xZr/VLIyvZ+YtIN0A==
X-ME-Sender: <xms:E9IsY-lgY_ho1mCZU6OGT74D_5jI18EvVv_MrONjS-a-EfcPW7C6lw>
    <xme:E9IsY121I7gb_r53vQ4O9B2lNzmKKS_FynnE4J8obJ1FbsapP9hbYfnvrz3jtM1m7
    5kEwnBTDxp9H8oyFvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:E9IsY8oeQksar82wOFJC7eB6v68g5IpT3eWJCNduXh4YptDgHXlb-A>
    <xmx:E9IsYykE7EVAD1YU1z0OIpVIWZ7m_CTtlyOu5ACZVw_-H7pEdPCnrA>
    <xmx:E9IsY81fSnH8fR65CuPwjwFK0U32JyUcHhT5Mb4mQsoOLOvIPUkzAQ>
    <xmx:E9IsY6C5grSqbvP86x1XZGj7EuFM90gwf__KW80jyndid27exKQwlQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6948DB60086; Thu, 22 Sep 2022 17:22:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <79fed88c-7dae-4131-a005-b8374b5fe660@www.fastmail.com>
In-Reply-To: <8c1c4506-bd21-a35e-d6e5-3c7897715c18@gmail.com>
References: <acdecda4-b11a-4e15-9ac9-6d2696218012@www.fastmail.com>
 <87427dd0-7307-57b2-4008-2ffb839a099a@gmail.com>
 <CAHk-=wiux9J6zi8sEHyLBVYc7zsWe6JwYOf7ggF+Oowc6fp4tQ@mail.gmail.com>
 <8c1c4506-bd21-a35e-d6e5-3c7897715c18@gmail.com>
Date:   Thu, 22 Sep 2022 23:22:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Florian Fainelli" <f.fainelli@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.0-rc6
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, at 8:17 PM, Florian Fainelli wrote:
> On 9/22/22 11:13, Linus Torvalds wrote:
>> I could pull your Broadcom fixes directly on top if you/Arnd would
>> prefer that as a solution?
>
> Thanks for the offer, no real urgency on my side, if there is a -rc7, 
> maybe Arnd can submit a follow up for ARM SoC fixes, as there is a good 
> chance we will accumulate more of those between -rc6 and then. If not, 
> and Arnd is fine with it, yes please pull mine directly, thanks!

Yes, that was my plan already, sorry for not making that clearer already:

I still have a couple of fixes pull requests in a backlog, including
yours. Since the fixes branch was already large and the rest has
not been in my tree yet, I decided to send whatever I had already,
but planned to pick the rest up tomorrow morning to send early next
week after I get a successful test result from the build bots.

      Arnd
