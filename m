Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330335FC583
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJLMlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJLMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EDCC8948
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665578467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bv29RAREeBAbvgsCg22WvWf89lmnsctG7Ho4iszploI=;
        b=U8aygZFCEZt8rvoGs5m6ow/ROh2wOI/DHI3aH3yDJ1DgFUOO8m0d1hUQlsKF+jugWIvpoo
        WB3Ci0shG149qBdc7WobETVD5WcDRqhiaRKKeAQFB7lGYEJTUcHTcdLosfE6Cc1EE76DFm
        3CW6Mimj0hXe7gtkxaMIXCOo5xy2ZMs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-ZPBVURhDNAy5N4IM4btQiw-1; Wed, 12 Oct 2022 08:41:05 -0400
X-MC-Unique: ZPBVURhDNAy5N4IM4btQiw-1
Received: by mail-wr1-f69.google.com with SMTP id k30-20020adfb35e000000b0022e04708c18so4973684wrd.22
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv29RAREeBAbvgsCg22WvWf89lmnsctG7Ho4iszploI=;
        b=0gsfKSfpj/YSGHB5TFT1+GUTYJ5QJNKWCseAFBTiX+ak4hMbSf1GNrYubZbfNq1eo1
         xaSFujKErxFvWQcA4d1QBLNzAetoM+4NKzbmJAZF4nkuaE+zDMxRIytGV6Zb6jdfrW9l
         7/hkRjuJr+JH8wQR+izZHT+zuscJ6vM/WIny4RGycA/REmZfQYIWKK2HQXyEFsqiF0VD
         TAW9ah8mQp2jzbUkrGNADOHymEaXkXhGT3V4qitBIs4R6iRlD9e5dr1Y2GBLWa6uoQkZ
         w0NUWG709qVU8H9QyEBZbTL23TmxzykyWKLFt5HSFrzqKGUtsJq62Pa0NXL/qvTKJd+m
         +A1Q==
X-Gm-Message-State: ACrzQf0AFvK6BAB2g/PuW2DrojQxYtnd8os5Xt5jGifejW9KEjDtlqs1
        uV9MAW3w0EGA9Er0vVzvAXRhIT4H9H5ttW4ms/HK8XvuDy3Bj0XLwagDsiPCLyBre6UpFO927+7
        IoZUncu647phsvx3QilU5/9k=
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr2667807wmb.11.1665578462814;
        Wed, 12 Oct 2022 05:41:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4dcKfBQlPa8rKv5cAIxddw7gshNEWnNWfy0+8T9tkuVfrvyH2Mi+L/rptrecqXCPaC5O45tg==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr2667793wmb.11.1665578462568;
        Wed, 12 Oct 2022 05:41:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6acb000000b0022afedf3c87sm13662057wrw.105.2022.10.12.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:41:02 -0700 (PDT)
Date:   Wed, 12 Oct 2022 13:41:01 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     frederic@kernel.org, mtosatti@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        atomlin@atomlin.com
Subject: Re: [PATCH v8 5/5] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20221012124101.zod6m2brlzpgx6nb@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220925010511.1482-1-hdanton@sina.com>
 <20221003124435.1769-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221003124435.1769-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Given work canceled because per-CPU pages can be freed remotely from
> housekeeping CPUs (see patch 3/5), what is added here is not needed.

Hi Hillf,

Firstly, apologies for the delay!

The concern is to ensure CPU-specific vmstat counters are reset and folded
into NUMA node and zone specific and global counters too before entering
idle. It is necessary to invoke quiet_vmstat() on return to idle even if
the scheduling-clock tick has been previously stopped.
Please refer to the complete scenario I described again.

If I understand correctly, indeed the remote drain/or free of zone
CPU-specific pages can be initiated by a "housekeeping" CPU i.e.
refresh_cpu_vm_stats(true) via a worker thread/or kworker, yet the actual
free will only occur when the nohz_full CPU exits idle code and calls
schedule_idle().


Kind regards,

-- 
Aaron Tomlin

