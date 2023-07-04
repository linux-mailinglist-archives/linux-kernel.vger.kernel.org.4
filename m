Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982BE7469A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGDG0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGDG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6CBE62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688451924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1UW578Mk3qJeWq3VtxngfydoAxkUFd/Ag1VEF+BPYE=;
        b=dj0XH1YaV7f+u8w4UVtv6r81f7yBmBBkPa1C4W4+ysRfJ/3fsebXffbRma0kgm4DTc8f3W
        u2IMlZZ3VwNwQAvFRNBhPHv+lc86bSjcjY4O+KRZzkJBYaQuLuNlr3Z4umuvc/GXdi92eh
        7q0C7Z0NFwWpXaE1HATddcbCkwscCWk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-JUidL0RGMEOGkBpqLYMDug-1; Tue, 04 Jul 2023 02:25:23 -0400
X-MC-Unique: JUidL0RGMEOGkBpqLYMDug-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-666ee6aeddbso5239106b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451922; x=1691043922;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1UW578Mk3qJeWq3VtxngfydoAxkUFd/Ag1VEF+BPYE=;
        b=XhhmzNwsMHNRcli15zRkkHu70KIdmNuXdFXlETKQitSWWZB/WhUAgL9zm+hEgx6hwP
         Z6AQYEiSLj/rYtmHCQsMvf/vHspvDK20xKvkeBIyrrjgpHLDYwnlaRPMVddijBNrhuN6
         AJPYqCYGmQkxXoTWwN3NYdzNPXOHNG+YibrZAXBgbm8U6byxTxYt61Ulnk+Hzk3mXBZb
         Y38v+8dfAUgbPcYEJqPGxNmZTbKfX38P89JsASEqR9v9eZtlsv8s7p5DqWm30PiP/6sq
         hR70tMyceFomkO0VK27UVqs3xxyZJKQ0d/APdp3hU4NyQiIDHexVbRw3CdgGWQjaJKbD
         CwsQ==
X-Gm-Message-State: ABy/qLaJ0vslc97oXUf2Ei9xgIIQhFHN4kwDV2FnEsJZjV4Wc52k85PK
        WLLt6hzwMHel7tlBe9WfCFi5cXCzHTvu1qGmlWUbXWzrL/TPfxNHoRdzj7ZKouL0u5fuJYZpixm
        dtub4ptYGlLTkfxnKeICgf0gz
X-Received: by 2002:a05:6a00:248f:b0:668:852a:ffc4 with SMTP id c15-20020a056a00248f00b00668852affc4mr14313188pfv.4.1688451922014;
        Mon, 03 Jul 2023 23:25:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUEat3h/Gp4e2swECKkXvj+rcpMv0mMF7hjDvc6iNbxstabGj8dzc4eRLol97NHSQTyjCYrA==
X-Received: by 2002:a05:6a00:248f:b0:668:852a:ffc4 with SMTP id c15-20020a056a00248f00b00668852affc4mr14313175pfv.4.1688451921738;
        Mon, 03 Jul 2023 23:25:21 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b0065da94fe921sm8688303pfi.50.2023.07.03.23.25.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2023 23:25:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date:   Tue, 4 Jul 2023 11:55:15 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D903A1FA-A56B-43B5-9A65-6F25EC0B5137@redhat.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23-May-2023, at 11:06 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
>>>=20
>>>> Olaf, is this a reviewed-by from you? :-)
>>>=20
>>> Sorry, I did not review the new functionality, just tried to make =
sure there will be no regression for existing consumers.
>>=20
>> Okay, this is fine, too. Thank you for looking into this.
>>=20

Folks, can we close on this patchset sooner? We at Red Hat also are =
interested in seeing this feature merged.

Thanks,

