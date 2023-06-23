Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91D73B85A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFWNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA31BC6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687525278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vcu9IDO2pMlCXuz9+9dp8wFxn2b0ImO0mUp8HiDtyZ0=;
        b=PSSdhVQqZTpV5XaDBhiNhP9jORj/pQvxX7/eoMB+tXVeVqUZGKiRmEHj2t/ZltT1jUnzPV
        DFaLyBxeYeKSZltF5gmYzNEsXlWaue36BsvKtXq2V/ql23doI24j2V+9QfgZfI5iDm+lVp
        e8zXpnc9ENdzHtaL6NbVY1aIpLXaiOs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-7-aEsdcGNOCTo7PcUkZYTg-1; Fri, 23 Jun 2023 09:01:15 -0400
X-MC-Unique: 7-aEsdcGNOCTo7PcUkZYTg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765478b08c1so11497885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525275; x=1690117275;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vcu9IDO2pMlCXuz9+9dp8wFxn2b0ImO0mUp8HiDtyZ0=;
        b=kahrBKKkKPcQDHGdvS5aJRxRhyHVuhEpB1BEv2HupWnBlvvvY1jW7hlXPeU3drp5u4
         oZTfvY5Myxbr2QJqw9EHjrEwsFlJIgZhNyVReuWUJG+13f0W6efDyNb1OzFbiZooTWh6
         NtkROktAnQDTv7UzDTqipVyi2OR71oU7YMNsJzrAFjDt87zX/vEp8KplJN48LftyTfdh
         GOXjFlOZ+PrbHiTXuMbD/jAV6I/sjt5tKMdZR0gahnaCRwu461qi4gSCSUsvbtUYi1c5
         JXQEW+8HSz+cYoutU498aD1fov5OMJOnDgRhp5PZzvXLhXL2NcAuxLS2/fyWB8ZQui4s
         zp9A==
X-Gm-Message-State: AC+VfDy5laifrD0cL6jasbkldjREUrAK4X1T3aV69+eOqcswp438gbBl
        +Zt6nMtecTSaqYX3xWDLW07M6tRXtvd83MFdWypcnNl0wqBWO2jHr0vQ6KmWsVWBaJZBZlRAbCB
        9YpzbMv5SUCSzixdDUucAOrZk
X-Received: by 2002:a05:620a:8fcc:b0:763:a95d:b578 with SMTP id rj12-20020a05620a8fcc00b00763a95db578mr10429909qkn.3.1687525275372;
        Fri, 23 Jun 2023 06:01:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65g/cWwRlDyAd07dNn5XZg3kkI+SKLStX6DcSCzrFYWBvpxMBMZ2eh/zC2N+DFadQpxllzww==
X-Received: by 2002:a05:620a:8fcc:b0:763:a95d:b578 with SMTP id rj12-20020a05620a8fcc00b00763a95db578mr10429856qkn.3.1687525274650;
        Fri, 23 Jun 2023 06:01:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a165200b00763a3e5f80dsm4526927qko.15.2023.06.23.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:01:14 -0700 (PDT)
Message-ID: <71f51047892001e6cdac1de4a6f7c2b9f97c7c8b.camel@redhat.com>
Subject: Re: [net-next Patch 1/3] octeontx2-pf: implement transmit schedular
 allocation algorithm
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net,
        willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, naveenm@marvell.com,
        edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, maxtram95@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org
Date:   Fri, 23 Jun 2023 15:01:09 +0200
In-Reply-To: <20230622085638.3509-2-hkelam@marvell.com>
References: <20230622085638.3509-1-hkelam@marvell.com>
         <20230622085638.3509-2-hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-22 at 14:26 +0530, Hariprasad Kelam wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h b/drivers/n=
et/ethernet/marvell/octeontx2/nic/qos.h
> index 19773284be27..0c5d2f79dc15 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
> @@ -35,6 +35,7 @@ struct otx2_qos_cfg {
>  	int dwrr_node_pos[NIX_TXSCH_LVL_CNT];
>  	u16 schq_contig_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
>  	u16 schq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
> +	u16 schq_used_index[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];

This struct is already quite big, and you use schq_used_index[x][y] as
a bool. I think you will be better off changing the used type
accordingly.

Side note 'schq_index_used' sounds a little more clear to me, but could
be simply ENONATIVELANG here ;)

Cheers,

Paolo

