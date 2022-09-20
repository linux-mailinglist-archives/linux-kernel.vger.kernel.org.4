Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3980A5BDFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiITIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiITIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B7B1F5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663661912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYBXnM221OKkMmYnX56agU4HA29O1+0qE07dmbgFr1Y=;
        b=UYQL6cEZya3EUjGuAX728tyovitTPhL9jkC0WN7/7QCtsPIrwcJ+AxME126OXPejI6Jpo0
        OR4D/2h/lpa8hU9NR/KxM7EYRApNN4J2C204Zt5ulVc5l7W8qmtPlfWQpjFjQXVjYD7FR1
        X/o3F4atgzIWhZLcyjuwVDMW4/R8vC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-31-aEtLuz6sNy-JJYCRCAJ8jg-1; Tue, 20 Sep 2022 04:18:31 -0400
X-MC-Unique: aEtLuz6sNy-JJYCRCAJ8jg-1
Received: by mail-wm1-f69.google.com with SMTP id c188-20020a1c35c5000000b003b2dee5fb58so811857wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nYBXnM221OKkMmYnX56agU4HA29O1+0qE07dmbgFr1Y=;
        b=bHLfHG6JH/BPjEkaXOuIfA5rsKUZi7qB6fLgqX0GnePyRx3RwRvXz3PYvIJcDRmS0x
         aT8pe0XRGLXga4ieKQMV9c+2qF4bG13xjn0A83ZHrvLKNeUTplGNeKVzhfcsrdo0r8XI
         dr50uAZawv/p2+eN+iwqZv8l+tGEn1k+4BiwDezWbQ/33q2+T4vZi36SINr7KCbZJNhk
         0VhbeMW9Uwrq1eDoACAIeUBjBgSjSdEZ867QFwWexzaLr4tfw9g+/sUQWgBp9lGwWkDv
         /O0DCQ+HOdJHGHMSMPhH/tyINDQ+8qnAxcQn1b7cOT59CWI2gmn2wLmSyvfSGYV5i07W
         p5vw==
X-Gm-Message-State: ACrzQf24Vp68KzKAPHKwNZNJLa+8OV3DbaT3MlbcV8f/ZCzK0v9lvokr
        eJqD+J5A2bzSbtFljOxnc+KkIzPC4JpdbsQjtQduLvOp8CtYGaSAeZ+rLIzl+r5FYHVveXT3oKY
        8suYg+Qb7LI/KCvRvN9R+w5QP
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id s5-20020a5d4ec5000000b0022867078472mr13700964wrv.12.1663661910615;
        Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Gc746EtqOMp12PC/ZhI3qlffavJ9O8HKgnaDgO6702xNdn3VPX99CEZYZBDDZBLY3QzW+vw==
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id s5-20020a5d4ec5000000b0022867078472mr13700953wrv.12.1663661910369;
        Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003b4868eb6bbsm1749112wmp.23.2022.09.20.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:18:29 -0700 (PDT)
Date:   Tue, 20 Sep 2022 10:18:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     vdasa@vmware.com, vbhakta@vmware.com, namit@vmware.com,
        bryantan@vmware.com, zackr@vmware.com,
        linux-graphics-maintainer@vmware.com, doshir@vmware.com,
        gregkh@linuxfoundation.org, davem@davemloft.net,
        pv-drivers@vmware.com, joe@perches.com, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] MAINTAINERS: Update entries for some VMware drivers
Message-ID: <20220920081824.vshwiv3lt5crlxdj@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
 <20220919104147.1373eac1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220919104147.1373eac1@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:41:47AM -0700, Jakub Kicinski wrote:
>On Tue,  6 Sep 2022 10:27:19 -0700 vdasa@vmware.com wrote:
>> From: Vishnu Dasa <vdasa@vmware.com>
>>
>> This series updates a few existing maintainer entries for VMware
>> supported drivers and adds a new entry for vsock vmci transport
>> driver.
>
>Just to be sure - who are you expecting to take these in?
>

FYI Greg already queued this series in his char-misc-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next

Thanks,
Stefano

