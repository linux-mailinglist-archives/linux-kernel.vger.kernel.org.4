Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A2643AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiLFBdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLFBdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:33:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE71AF3B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:33:52 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl24so12508497plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 17:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KOKKqWMLJKraCzEAdHnMpCuNAMfgKg7sMYZTRrdcoc=;
        b=cNFxX7TjKzNtIgTTlN5abRCyUj9EVxTpv15OkZsG+jVACZFsOTxNbdX7uH/3ZjWbIw
         0U1Ntx6jvZqPd5l0MQlQ5dSB/x4kqtJpmmbfuohPV/zhzMbAG0/5qs/dR+COf/6pcMJ5
         QlhrEruqkb91Vk04megDTqNoyNDjB3G74ejlk6zv+VFBOYQJBYleEjNDobF9E6Hb5bc0
         O8EgEIWfX7qnru8wSYTdYTyIutNTAigRAd0CvBY2pSFkDac0z6BCCSBPQ4AV0lVoM4tv
         YvYO7BXYXFR5APet7HttILd62C4E/3V91DEp5tZ+9LR7O69g95LVbd2fm848at9zwWyn
         aWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KOKKqWMLJKraCzEAdHnMpCuNAMfgKg7sMYZTRrdcoc=;
        b=1BzczIMaZVmr8yCoWhBwZNqzPyPAjIjOV6j5O5Zqgtv7Ud3sYN2aY64Z+Gc416wcRM
         og+/N1WdUZj9aLJOSLoVYFitqmeGhHb68ibEcg53Edy68Se7DsxlrB14/lyZ0fx166nz
         fGVJUjvq33PpuVW/aRmX5JKPq2vSS9NzZbtP5yhCzjijjprQiI67zJ0JnD3W/9BCPoim
         +8mFLpljI8dnn0/iFCuINtPZ2i0g9iJhLiT4u8vkhNEQZpQmIN4XEkpcpa0GPCio9beb
         GIi8a/W8oWNvsp5gZYU6vtfM/JgiKoXKEArGTvMv1Z5yB3bQ4yJafIMFIvzO/zdTHYtf
         o9JQ==
X-Gm-Message-State: ANoB5pnPmoz4Nqf4SJBVD+58Pg7/W2FHWNawhZMhHNZAPZsBBZnyIAMw
        V0cE/C1xaL3rJCme+IKeFvBEu8TAXvoOcA+Y6QpJcg==
X-Google-Smtp-Source: AA0mqf479b/GuJqXa8iX1dYZWDAt1jyTN+54yfFRRHeYn9m/3pi9IikYIMl/j58kNpOXzmUEmL9M2vTNqeD/YlskC+U=
X-Received: by 2002:a17:902:c1ca:b0:189:e149:a1b2 with SMTP id
 c10-20020a170902c1ca00b00189e149a1b2mr4402992plc.17.1670290431757; Mon, 05
 Dec 2022 17:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20221204084844.3573800-1-badhri@google.com> <20221204084844.3573800-3-badhri@google.com>
 <Y4xrpgCTqV4yAplp@kroah.com> <20221204155724.GA1862600@roeck-us.net>
In-Reply-To: <20221204155724.GA1862600@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 5 Dec 2022 17:33:15 -0800
Message-ID: <CAPTae5KvmBXJrYByttNz4mmubfP9M_jAJh8Gx=5hgn2PajBuVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] usb: typec: maxim_contaminant: Implement
 check_contaminant callback
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing both the comments in version 4 of the patchset. Thanks !

On Sun, Dec 4, 2022 at 7:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Dec 04, 2022 at 10:43:02AM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Dec 04, 2022 at 12:48:44AM -0800, Badhri Jagan Sridharan wrote:
> > > +EXPORT_SYMBOL_GPL(is_contaminant);
> >
> > Sorry, but this is a horrible name for the kernel global namespace.
> > Please properly prefix it to show exactly what subsystem this is from.
> >
>
> I don't think this needs to be exported either.
>
> Guenter
