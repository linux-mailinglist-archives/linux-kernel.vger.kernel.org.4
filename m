Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1035BE163
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiITJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiITJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E124F32
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663664680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZuuelmCdZJIaGRmn3zdMaH8fdIOdf58OKHfssRgDa0=;
        b=TYa/iqt34PPoKxFJK7PgU9VraHIFEY5G5a5Xt+4wi7K0XCVOPOm9ZFP0acHm7OL0370R9A
        O2yV0EYpayEW1PzaS+1kyi4ahS/cE4FQVUU6t5+2ubQUUaEuqFbkzj2avVM9bGZWyE4bH9
        EB7FSJ1Jkoj/i7PzkTWBu1j82EaaDIo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-5fN-MLkeMCW-3KcQKUmsMA-1; Tue, 20 Sep 2022 05:04:36 -0400
X-MC-Unique: 5fN-MLkeMCW-3KcQKUmsMA-1
Received: by mail-vk1-f198.google.com with SMTP id x3-20020a1f3103000000b003a285826de2so558614vkx.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MZuuelmCdZJIaGRmn3zdMaH8fdIOdf58OKHfssRgDa0=;
        b=x3gffkwY2DREvFJCMcLIVNT3xg127igIhfh1xqLLoX9PzvpPQe5Lom9KN7SI5T1BHF
         53nZn1Qe6e3ON/uSgAeqQVhK6p+y/JW7zgc7W+QGmOA4A4mDiTMXXspkDYFlDG/3Anqz
         kwxro+w6Uc4lbW0T+B3fgRiTj/rqBZNERQkfZKpSy4A+bvgd9aHvX92nq2VuUlqnTDZp
         ezwFdLXfzjZpBDuCzSetgB5lqVpcfFye3Hutgx1Vh1NX5V1vC49XMbDDdB2beGuGXO1r
         AlPeYob2/Ww58y2j5+4bZ9C8pdiW3dkHQFabQYCjn3DN2ghbj+6Sixjrjuo+Pe795nk1
         E1MA==
X-Gm-Message-State: ACrzQf2nSvrHV6PnNJUPQWqbytNNYgjPwPYMvgB7AiXc+pEDULAldY7z
        R033XuATjfphVYs9+3CYR1Ni3wnDiM4JsQgW2Tww7ZdMn0WWagRwEKZGqLa16VVUyggfxyGyQig
        Y2hNZ4GQMsxwPz+NNnjy3MFyrVEAvBZvMZfKA96ou
X-Received: by 2002:a1f:27cc:0:b0:3a2:4fee:940c with SMTP id n195-20020a1f27cc000000b003a24fee940cmr7455985vkn.14.1663664676189;
        Tue, 20 Sep 2022 02:04:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM55mKLjiCZZJ1LGDZ/yFqF/4GbHztomEwHpMG6PRYaEtOgu0iM+5StIwEp3Z6t/kRHvWgGz/Ixn0UtvFyi42LI=
X-Received: by 2002:a1f:27cc:0:b0:3a2:4fee:940c with SMTP id
 n195-20020a1f27cc000000b003a24fee940cmr7455977vkn.14.1663664676009; Tue, 20
 Sep 2022 02:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919094635.184804-1-ecurtin@redhat.com> <Yyleq43/IBofsMMn@infradead.org>
In-Reply-To: <Yyleq43/IBofsMMn@infradead.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 20 Sep 2022 10:04:20 +0100
Message-ID: <CAOgh=FxMBE_YEC89DmeF9g76aQXrvAH1DvUavS1FhNiXqEYhAg@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by default
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libahci.ignore_sss flag is something that is set by a number of
performance focused distros. The motivation behind this is to set
ignore_sss in a boolean fashion at compile time rather than depend on
cmdline parsing.

On Tue, 20 Sept 2022 at 07:56, Christoph Hellwig <hch@infradead.org> wrote:
>
> Err, no.  We should not add config options for every damn default.
> If you want to force it on CONFIG_CMDLINE is your friend.
>

