Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA66D1848
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCaHPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCaHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FE1B36A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680246909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWMFK/padud2qL2Yu5nuVXmsRK2hLBvg6h75c5M7KFw=;
        b=ce5FqbD973OR0uuL9me7U+UlE7kjD9jWV0CFfgp99sQd2jvtcqvTNNrCYmbnWJ0t8TUHJ3
        xmrBvRGEvO13hjF7wIiWYpoRdcHLcSI/hpm21HSENmuhBZ30in5dEejTCaSgW0OM1bRRl6
        77lkcXdlS07F/lmygAW7Z8TMiXzjWeU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-LoSJe8LEPMayu2JgtD72fQ-1; Fri, 31 Mar 2023 03:15:07 -0400
X-MC-Unique: LoSJe8LEPMayu2JgtD72fQ-1
Received: by mail-ed1-f71.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so30287073edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680246906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWMFK/padud2qL2Yu5nuVXmsRK2hLBvg6h75c5M7KFw=;
        b=JgZo4b6QsRS3l0BtWDFfSyPrfp/RkgGEBlFn8lbSLgJTbIYC1L7zSOcZb5E0iSA3tO
         eHwt1hROAoh7JJbnB+mQoRB9xbwVF+aiCn8ZcYv41NRtbVOXvHNz478mMrbXXopAPjNS
         r/NSeun/0hb+/30xZ9OC25MWs1jcOfvJLAIuDAlt8BJce6+21GIDl7iez+xA0clQSXEs
         LdCg1XDpa8ynSG8KuVilAhXy9sDUlqXIBO0NuJYlVotD2MSROnOU9svwoAkOaUiYX4Rk
         z9BWFLGNlSc9zkd1QCST99rcdN6eKJawlFskWv4NC/uHmY3MfXkSYDbo8FZvsGSbx0Ta
         QZyw==
X-Gm-Message-State: AAQBX9eBueNEUGuUsnYliHItAKYYO/xVp6+ZyFK9U9K8PHVlqpfsa/ZE
        az2rlJBobxXJrJrRB9ZI7AdpqGqjDjZ0tjJ7ZdvlUWqTXW6JdLrWdaV7clG0AcP72XShJzxmzXp
        IkC36Pksw605LCzas7+yzBNK9
X-Received: by 2002:a17:907:6d83:b0:947:6ce9:705d with SMTP id sb3-20020a1709076d8300b009476ce9705dmr5436214ejc.55.1680246906174;
        Fri, 31 Mar 2023 00:15:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350aZwogAdOwSVJvzr6Pjwq+TBHVkVowx29697Nam/rYpQ8g3Ha6PzoB/NgF8lkggQuyLgeScSw==
X-Received: by 2002:a17:907:6d83:b0:947:6ce9:705d with SMTP id sb3-20020a1709076d8300b009476ce9705dmr5436179ejc.55.1680246905861;
        Fri, 31 Mar 2023 00:15:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it. [82.57.51.130])
        by smtp.gmail.com with ESMTPSA id v13-20020a170906b00d00b009373f1b5c4esm649065ejy.161.2023.03.31.00.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:15:05 -0700 (PDT)
Date:   Fri, 31 Mar 2023 09:15:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        oxffffaa@gmail.com, pv-drivers@vmware.com
Subject: Re: [RFC PATCH v3 1/4] vsock/vmci: convert VMCI error code to
 -ENOMEM on send
Message-ID: <rrapkoibcd6p33pmai2egr6isphvbx7rlu6hfj74gsmuih5p2o@kdilyljzs5bm>
References: <dead4842-333a-015e-028b-302151336ff9@sberdevices.ru>
 <a0915a9d-ba41-5a90-0e16-40c2315f0445@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a0915a9d-ba41-5a90-0e16-40c2315f0445@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:12:44PM +0300, Arseniy Krasnov wrote:
>This adds conversion of VMCI specific error code to general -ENOMEM. It
>is needed, because af_vsock.c passes error value returned from transport
>to the user, which does not expect to get VMCI_ERROR_* values.
>
>Fixes: c43170b7e157 ("vsock: return errors other than -ENOMEM to socket")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

The patch LGTM, but I suggest to extract this patch from the series and
send it directly to the net tree, while other patches can be sent to
net-next.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

