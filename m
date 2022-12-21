Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53214653700
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiLUT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiLUT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:27:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634926488;
        Wed, 21 Dec 2022 11:27:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f18so15950953wrj.5;
        Wed, 21 Dec 2022 11:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkkerIbTQRTLKfMM8XBekx5TC2De5yyo6l84xOP+BWg=;
        b=qathmJ91HV6S3U239XfaprIuoOJywlcGDlLPlLONxaGFHRvj+5gW8uTphh2dROgb+X
         vbe+SwTZpm7j33b6daVjtML/tSIzsM+fSUC++OACoJDIjG1tndbiYjUb2FreDHp6SzZH
         eTUQde2FxrDo5H1gUimNPTzxRX7hmb6FvoYmnM4si2jUzTj08EMidk+ZHsjsg8etUFs1
         Fk4ZTJOSFKZvOEnyL2DaAMYb0wKvcxOgRSBlntSY8o6hvGTFlNMCyrJtEfv711ZB8br3
         dTDCPQxb+MIidKjtWpLEJUtVhNRynKIJtC5WHARefeIs2DcJm/x+oNv1xzUz1Ok/zahN
         Zo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkkerIbTQRTLKfMM8XBekx5TC2De5yyo6l84xOP+BWg=;
        b=FwUijW1kdtplm970j9H5xQjCpS3RL1+UQGakdiO+tmZindby4YAMzoY97NQLaqc0XZ
         7Wba2dRMbg0yQwF1AV3XmZh46yZFIq8XeGFclmKOeqhPef/sAkoXNAjdzw0XHqgkEnwj
         s5re73pwipQzYy+5YG9xU2b2Ma7ZjBUJ9NSw/elxnnGi60tRoBXcvQLNepdzNisgdpQK
         A9KWIFjvb7/MKI6I6bJ3Lh/drAONzAuvBsfHH0KV0SVgXW6CahGQVeTKh383KUufyjA/
         ZoZn4cc1EN1jdhWlE5OLOrw/9Z36gOER+YlbqHFVS6Br+kSyH6F3zTSshvvRQHK05Bsa
         Fr9A==
X-Gm-Message-State: AFqh2kqGNfJUpkGx7zkuwuxGfLKR/wCmJFX+4/kjW5DJg0I+WqBGsl7U
        kUa8rMUfqHjbgD78GbwYG4XrShz2oWg=
X-Google-Smtp-Source: AMrXdXvv1ovorFQ5LGZkJ8J85JItA7IWIp4nv3elwgNyty2zqIORd8vZyBiQQV6GutDegH0AAkzr+A==
X-Received: by 2002:adf:f781:0:b0:242:1ba0:208b with SMTP id q1-20020adff781000000b002421ba0208bmr2155008wrp.64.1671650872831;
        Wed, 21 Dec 2022 11:27:52 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d67ca000000b002426d0a4048sm16123074wrw.49.2022.12.21.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:27:52 -0800 (PST)
Date:   Wed, 21 Dec 2022 19:27:51 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Sam Li <faithilikerun@gmail.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED
 check
Message-ID: <Y6NeN2H0Tmi0QRGi@lucifer>
References: <20221221145433.254805-1-lstoakes@gmail.com>
 <20221221141451-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221141451-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:15:58PM -0500, Michael S. Tsirkin wrote:
> I think this was fixed by
> Message-ID: <20221220112340.518841-1-mst@redhat.com>

You're right! Sorry I don't usually pay attention to virtio stuff, so missed
that this was patched already, just noticed that my dev env was killed by the
issue.

I have tested your patch + confirmed working so will at least add a tested-by to
it :)
