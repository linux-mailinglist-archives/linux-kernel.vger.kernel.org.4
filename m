Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1585873693E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFTK1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFTK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:27:45 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66FE3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1687256865; x=1718792865;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=H9kKhhXvXMK0Gusjj0KXUUTTcFnasirU/KwXcgWZft8=;
  b=lweT8NbUMaUS/lKw9K6klIk9vUy95JOLu3M+NEBgy2+h0L0hH1X1NxuN
   72AYxRw3UWiZhsDTXR4BZUTkPRvcs+QmWN+bXk+09bxDFDFIRNruwwxmn
   kVAdvJbwEMoqok0v5Sko8buYWZwg78Sw0HXESmCkX5c4nfBDwGD/jR4r3
   c=;
X-IronPort-AV: E=Sophos;i="6.00,256,1681171200"; 
   d="scan'208";a="1138494281"
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:27:37 +0000
Received: from EX19D014EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id D84E540D7C;
        Tue, 20 Jun 2023 10:27:36 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D014EUA001.ant.amazon.com (10.252.50.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Jun 2023 10:27:35 +0000
Received: from [192.168.202.200] (10.1.212.45) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Jun 2023 10:27:32 +0000
Message-ID: <ad46e3e2-20f0-2384-0bde-37fa856e9eb1@amazon.es>
Date:   Tue, 20 Jun 2023 12:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
        <graf@amazon.de>, <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20230531095119.11202-2-bchalios@amazon.es>
 <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
From:   Babis Chalios <bchalios@amazon.es>
In-Reply-To: <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.212.45]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 19/6/23 22:30, Jason A. Donenfeld wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> Like the other patch, and as discussed before too, I don't think this
> has any business being part of (virtual) hardware drivers, and instead
> belongs in random.c, which might receive these notifications from a
> variety of devices, and can thus synchronize things accordingly.
> Please stop posting more of these same approaches. Same nack as the
> other ones.

Quoting the cover letter of this patchset

> Please note, that this is not a "you need to reseed your PRNGs" event,
> which was what the previous RFC [1] was trying to do. It is, explicitly,
> meant to be a "you are now running in a new VM" event for the user space
> to consume, so it can do things like regenerating its MAC addresses and
> refreshing DHCP.

Why do you think that the "you are now running in a new VM" event (that has
nothing to do with PRNGs) belongs in random.c?

Cheers,
Babis
