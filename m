Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6F6DDAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDKMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDKMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02B2D4E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681215789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NO8m/39itoQ88ondd8aih0YTi65wTxu46iy4CYCM2g=;
        b=f6ndSaxFJcLD6yZecpIFiuPkrMn9tslifBV253y9JgfEu0/MC+XcX69fVMHSXiuVhFp/g7
        /rDZD9DAxv8b5mLA9jTlpCzYz4SczU2jSyEqX2TKV4J1NhofACMWydiTKX2h9X8+UL8fM5
        SZchXdil1f7qMELnRGtfe4k7OMMG010=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-9JzyYxP1Nya5o5lVoenZ8w-1; Tue, 11 Apr 2023 08:23:08 -0400
X-MC-Unique: 9JzyYxP1Nya5o5lVoenZ8w-1
Received: by mail-wm1-f70.google.com with SMTP id q19-20020a05600c46d300b003ef69894934so2275065wmo.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681215787; x=1683807787;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NO8m/39itoQ88ondd8aih0YTi65wTxu46iy4CYCM2g=;
        b=6KaoAatYHcRQFd81Oitk3sEMQsmJ/UXMUKOGG2qefiG/2T849i6uPvzhiMd2ZBNFHB
         9vgVzB3EsBAWh2im4YMazwitT5TibwnMfBYMRdR9/wIlFU1l3qHt4ytzcBHnn2b7tdDW
         kqRLlawgwJIUKZdHmOo982tlkRrWAECAv/9t9HqHcX9sw7q+pmm5frbHSOCV4zGc02FW
         ZfcJVLPpAFJrRSh0clXS7sQ0Rmw7JaiIxRl4RllKUyd9QaWvF3O1F/HtpbpMhYuPeeA3
         Da0QN+tkFNOAJO5Sk/xj/qFrookAH52VbU1prcOq3gwOIyaobXBBU5JzpkoqyBexnvRt
         Lu7w==
X-Gm-Message-State: AAQBX9dQRGAHpUDqS8LiXIER/O9obAt9HbpVNRCevsUpqpokNd0dVD7j
        BxLUFZGtDRgg3ZHLIQ9ZGAWZID725E91+7vd/ilO/0ZkqYjrAGZoINHHsz8nEnzTd63If1aVSQ5
        pqURWHQm1wxfoWsBW1nY7i25ZLaXTL9Ym
X-Received: by 2002:adf:f986:0:b0:2f0:58a:db82 with SMTP id f6-20020adff986000000b002f0058adb82mr5276605wrr.36.1681215787223;
        Tue, 11 Apr 2023 05:23:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bZVla4xUIdyunyZ5GslESHnU5aHO2Ua9sEjV9sz3CusPberEtCDqWgto+JaCchijgLC4uwqg==
X-Received: by 2002:adf:f986:0:b0:2f0:58a:db82 with SMTP id f6-20020adff986000000b002f0058adb82mr5276583wrr.36.1681215786936;
        Tue, 11 Apr 2023 05:23:06 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l1-20020adfe581000000b002f22c44e974sm4642841wrm.102.2023.04.11.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:23:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, dgonyier@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH v8 1/2] sched/rt: fix bad task migration for rt tasks
In-Reply-To: <xhsmhile99qdo.mognet@vschneid.remote.csb>
References: <20220828170303.171400-1-schspa@gmail.com>
 <xhsmhile99qdo.mognet@vschneid.remote.csb>
Date:   Tue, 11 Apr 2023 13:23:05 +0100
Message-ID: <xhsmh4jpma9qu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/23 12:55, Valentin Schneider wrote:
>
> Sorry, I lost track of that one, and ironically it looks like we've hit
> this bug internally. I'm going to test whether this is the cure we need,
> but even if this isn't the same issue, that patch looks good:
>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>
> I have some more comments on 2/2, but IMO this can go in on its own.

Seems like we were indeed hitting that bug, as we used to have a MTTF of
about 2 hours, and we haven't had any with that patch in 3 days.

Tested-By: Dwaine Gonyier <dgonyier@redhat.com>

