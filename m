Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E12632E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiKUVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKUVOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:14:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6819D1B7A6;
        Mon, 21 Nov 2022 13:14:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F389B81626;
        Mon, 21 Nov 2022 21:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0754FC433C1;
        Mon, 21 Nov 2022 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669065261;
        bh=joUmK9IVGh+nke5W6ci9J36oOowc8GoGYbGdGWzwDJ4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ldy672TjeQEgRX6Y0gKoZK7TXFKaj/3Rpm75glNNUgXTqdguLq7jEUDtvzmnocwuC
         fyfmLYWYzIUepqRpLED1oQ3kPYXxQYW5xFCOqjoveM90+RncL0RxCe8BllGte3jCdH
         IFHOZP/gmqyNGIiFv8bcfO3OzAEbbil2j/o3niOyOvM+1D/ZV4Flurrp7lOG3Jjn2J
         EEF5lxBDhCBZXMTMg734qUAuRO5IeRIQfO/hqNE0KdtlZzGV5Mb60pwvJXD2L0g0B6
         WXmLYIt1Gj+GupRqArKalIM49Eqlp4VD14UT+l9u+uDnE0k8co7sOR2Q1ANZKs13pD
         Zt2MINEXzN3tw==
Date:   Mon, 21 Nov 2022 22:14:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] HID: hid-sensor-custom: set fixed size for custom
 attributes
In-Reply-To: <20221117121326.5621-1-marcus.folkesson@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211212214080.6045@cbobk.fhfr.pm>
References: <20221117121326.5621-1-marcus.folkesson@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Marcus Folkesson wrote:

> This is no bugfix (so no Fixes: tag is necessary) as it is
> taken care of in hid_sensor_custom_add_attributes().
> 
> The motivation for this patch is that:
> hid_sensor_custom_field.attr_name and
> hid_sensor_custom_field.attrs
> has the size of HID_CUSTOM_TOTAL_ATTRS and used in same context.
> 
> We compare against HID_CUSTOM_TOTAL_ATTRS when
> looping through hid_custom_attrs.
> 
> We will silent the smatch error:
> hid_sensor_custom_add_attributes() error: buffer overflow
> 'hid_custom_attrs' 8 <= 10
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to hid.git#for-6.2/sensor. Thanks,

-- 
Jiri Kosina
SUSE Labs

