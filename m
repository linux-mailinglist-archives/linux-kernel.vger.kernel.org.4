Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F068BB50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBFLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBFLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E83BEB71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675682517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rafAKTYUsDlGbQHQV0/aM7U/03fIHVj84G99wJbP+2k=;
        b=b7nfVu+iV4S1Lfona0OgEcMeiOh9nJfT/Rf1kv9eIKNUx2XCc2x4BU0YXWJ04hK5dVnDi2
        ETb5ZzBUzlu3ecXmABcyEOTS9+xVbB6cKzFdby8PDhZbVLi/LgskX9hIOlvV8hEccb1hbT
        4Mg6FTzNq5g1YOLxgdqLyT1CZwTR3Io=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-JjJxEdWhPvufoniSCZvU9Q-1; Mon, 06 Feb 2023 06:21:56 -0500
X-MC-Unique: JjJxEdWhPvufoniSCZvU9Q-1
Received: by mail-ed1-f72.google.com with SMTP id bq13-20020a056402214d00b004a25d8d7593so7427871edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rafAKTYUsDlGbQHQV0/aM7U/03fIHVj84G99wJbP+2k=;
        b=oozlCcgaZeEd+K4O+2N6oYquxbE9mSGh3HskxQYWrMANXI0D1wfuZLZfC0OUiUNNv4
         kqo0pQk+SsWEFo505SVD4oY5ioeEdSEMI1W2eYcUrFm9H155y1AnKQFHzX4+Omk13EMX
         hSxX2RlC4rOwbzLUM9gnWCqp4tK8EfR4NmWG9Ap5HnrE8QDIp45/yxdo5RQ6TyJQ+GOu
         Wrbt2CtwWtg+MFI/I0cq/WtxEpPp3JvfqhOSSkZrkqUij6WYIpx6v9N2Cyh+S3btx4Dd
         5hKjfopU+YlQLd0OVgLZXUhH6kHu15yy8s/6u4rtRhUJ4oJehpxcH24F88z8pjURzWwe
         Z3AQ==
X-Gm-Message-State: AO0yUKV6F1CnZ3KSViwDDDkk/ci7EMAKwU1hJbLtVnQFGCLUq4eNgMGK
        +xEv+VnrxogZvGiPf35s/PglDv4hqCQgrXv3DAqcEuq5+b7SfBsIErlDNbTivla85eX/DRUE8aj
        7+UXKSzHeelLFzBZCU2IAuHgG
X-Received: by 2002:a17:907:629b:b0:878:4e5a:18b8 with SMTP id nd27-20020a170907629b00b008784e5a18b8mr1091812ejc.66.1675682514944;
        Mon, 06 Feb 2023 03:21:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+Lk/4XKusHHqrN+0wXTYdczt6X11167XWSiY9EW6TmuQApfe22tAB5UxHlUy8RM2WSlkejow==
X-Received: by 2002:a17:907:629b:b0:878:4e5a:18b8 with SMTP id nd27-20020a170907629b00b008784e5a18b8mr1091795ejc.66.1675682514743;
        Mon, 06 Feb 2023 03:21:54 -0800 (PST)
Received: from [10.39.192.186] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id bu18-20020a170906a15200b0088351ea808bsm5298395ejb.46.2023.02.06.03.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 03:21:54 -0800 (PST)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Eddy Tao <taoyuan_eddy@hotmail.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v8 1/1] net: openvswitch: reduce
 cpu_used_mask memory
Date:   Mon, 06 Feb 2023 12:21:53 +0100
X-Mailer: MailMate (1.14r5940)
Message-ID: <BB520D08-D1D3-45DB-A3AE-008E8DF48F81@redhat.com>
In-Reply-To: <OS3P286MB229570CCED618B20355D227AF5D59@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB229570CCED618B20355D227AF5D59@OS3P286MB2295.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 Feb 2023, at 2:35, Eddy Tao wrote:

> Use actual CPU number instead of hardcoded value to decide the size
> of 'cpu_used_mask' in 'struct sw_flow'. Below is the reason.
>
> 'struct cpumask cpu_used_mask' is embedded in struct sw_flow.
> Its size is hardcoded to CONFIG_NR_CPUS bits, which can be
> 8192 by default, it costs memory and slows down ovs_flow_alloc.
>
> To address this:
>  Redefine cpu_used_mask to pointer.
>  Append cpumask_size() bytes after 'stat' to hold cpumask.
>  Initialization cpu_used_mask right after stats_last_writer.
>
> APIs like cpumask_next and cpumask_set_cpu never access bits
> beyond cpu count, cpumask_size() bytes of memory is enough.
>
> Signed-off-by: Eddy Tao <taoyuan_eddy@hotmail.com>

The changes look good to me. Hopefully this is the last revision ;)

Acked-by: Eelco Chaudron <echaudro@redhat.com>

