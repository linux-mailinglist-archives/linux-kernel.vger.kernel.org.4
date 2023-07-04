Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57239747A90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGDXzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB61AD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688514861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PORwtyRFGlG4lvPZI8qM6TQsPqsUfbHMoOVfE2D1XLI=;
        b=W7TWEHf1FgBXwx+m2ziG39ABk7FQHxxNKl2TFsLhqe1EKV/kM+LzWeXjaTfnPBui4wLmqz
        9WCsggVEXmOfl4QqvBIpv1spM3aDzrqqxK3oQPzyasVo/Ca6areOugBm+Eq3iS/RdewQDJ
        CL/IP8dGlEhMyP2NCx2/FdMgfmt/6aU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-uDPmvNHYM8KNph94zY6VbA-1; Tue, 04 Jul 2023 19:54:20 -0400
X-MC-Unique: uDPmvNHYM8KNph94zY6VbA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbaade0c71so37959185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 16:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688514859; x=1691106859;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PORwtyRFGlG4lvPZI8qM6TQsPqsUfbHMoOVfE2D1XLI=;
        b=QRstXRcAs8bvC6gOrpHBJRzMNIJPu9BonNXgPE3go0Y0z3DSgPpfs+nLm4Bol/o9qF
         FiiCB8G8ARp8jyFr7Leg4ccVYAG12ZB2H5ebMCUPSHr5e7GbYtIpX9xfq4pxQo9DWtFz
         la7f9ml5AU6DkIp/Swx5GoMz8nxDvxnQZqy3tem6XsBBbddfQ/hYvBhxOBTvaeljUfWh
         +o0cP1rjBo/gh/J4Maph/eA9Y3OZkTKxqvJQ7u/H13wJx7+v4qNpR7CA8gDYaumZ//LY
         elXrb+iCq+aJtkI6LkYSCv4ztRKlrd4DnONeOmUYMa/45GtUZOKCv+wm4OceYAbRcU+G
         uMag==
X-Gm-Message-State: AC+VfDw1Wncz4gj72oqhwBFdHrrNKreL5wHCoxz95Xmi+aB0dvp4P/tz
        TY7BWB63bnT7NsvU/z2RZ/lIFxlXYatDVJV9qAazhGp0a+TsZxXik3QgmB0aoh5YmmwjEGrFoPe
        NbrUn2g3gOiu6Ye/Qlzj3ruDE
X-Received: by 2002:a05:600c:3787:b0:3fa:8c67:fc43 with SMTP id o7-20020a05600c378700b003fa8c67fc43mr12744026wmr.32.1688514859029;
        Tue, 04 Jul 2023 16:54:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tq90DzBUFgJTJaEJ4Ac9MVzBo9lw3N89KMFWnG6tpF5auyzg3GBH2U3SFnJuMDfeVAFVYtw==
X-Received: by 2002:a05:600c:3787:b0:3fa:8c67:fc43 with SMTP id o7-20020a05600c378700b003fa8c67fc43mr12744017wmr.32.1688514858642;
        Tue, 04 Jul 2023 16:54:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm457745wmi.23.2023.07.04.16.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:54:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 45C8BBC118E; Wed,  5 Jul 2023 01:54:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrew Lunn <andrew@lunn.ch>, wei.fang@nxp.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: fec: dynamically set the
 NETDEV_XDP_ACT_NDO_XMIT feature of XDP
In-Reply-To: <5b1182d5-a147-4bfd-9ac8-b33462e97b10@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-2-wei.fang@nxp.com>
 <5b1182d5-a147-4bfd-9ac8-b33462e97b10@lunn.ch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Jul 2023 01:54:17 +0200
Message-ID: <87mt0bb5cm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Jul 04, 2023 at 04:29:14PM +0800, wei.fang@nxp.com wrote:
>> From: Wei Fang <wei.fang@nxp.com>
>> 
>> When a XDP program is installed or uninstalled, fec_restart() will
>> be invoked to reset MAC and buffer descriptor rings. It's reasonable
>> not to transmit any packet during the process of reset. However, the
>> NETDEV_XDP_ACT_NDO_XMIT bit of xdp_features is enabled by default,
>> that is to say, it's possible that the fec_enet_xdp_xmit() will be
>> invoked even if the process of reset is not finished. In this case,
>> the redirected XDP frames might be dropped and available transmit BDs
>> may be incorrectly deemed insufficient. So this patch disable the
>> NETDEV_XDP_ACT_NDO_XMIT feature by default and dynamically configure
>> this feature when the bpf program is installed or uninstalled.
>
> I don't know much about XDP, so please excuse what might be a stupid
> question.
>
> Is this a generic issue? Should this
> xdp_features_clear_redirect_target(dev) /
> xdp_features_set_redirect_target(dev, false) be done in the core?

No, because not all drivers require an XDP program to be attached to
support being a redirect target (which is one of the reasons we
introduced these feature bits in the first place :)).

-Toke

