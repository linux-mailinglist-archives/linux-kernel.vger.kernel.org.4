Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46473663E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAJK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbjAJK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB31C13D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673346474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KIby0sHbh660F6W00pOyfjQiD0YxkgesI7WCpTcF84=;
        b=EAL0Rq/UAEVualdmxWIfF+UqbDhyA3COr9Hu9J6aRZE5ZYe0fjeKwjKh6EwoYCtZ8hdylg
        xCeQMKA1gl3QIiS9r5l9KMTTZzjfX25tDjJ5bRotQ1ROJO4hWK3q949mKPdH2JRLE8QqE/
        P5n5dPp308vLWKq0hSIjQWL/1Qdovto=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-nCD2Wls8MlmaYjiJx-wJVA-1; Tue, 10 Jan 2023 05:27:52 -0500
X-MC-Unique: nCD2Wls8MlmaYjiJx-wJVA-1
Received: by mail-qt1-f199.google.com with SMTP id z16-20020ac84550000000b003a807d816b2so5253516qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KIby0sHbh660F6W00pOyfjQiD0YxkgesI7WCpTcF84=;
        b=T0JZ2d7D0kweYSRmMvUaKn+vGsC9g+CMiaND0DdKlxxzQly24OT4BEWC55N7Uou1G1
         R8Za2eJYpwCPow79SK5DSOtUbT5ouk5rMlIYuZ07OvOR7SM5OGYVQWrY1BcT0KFRHYRO
         NWTIREydQoNvFqHXBVRzAhUuV6kKtC+l30pT6w5LLWOmFw6lJ4xqAiQ5ZvrCSRXtWVbt
         KXLE4qWud5m6Z330FgF3pDVjpRE+BTtU5+FZu9Gfw4kytejtPEYCJK2q7juJ0mEfz/Sy
         LrXcUjyHc0y+idEG9BLc0Pd8HnveNMp6Ibcii1QCk4ocaYIAkTL5niyV+zG1lVUAoWCO
         kLnQ==
X-Gm-Message-State: AFqh2koY0GLa3bzrvyHJOe9Z8nd06ri3VuIiLcr+VU7Gh1Qkc74pcraf
        mwzHN5yyiZdZpmNTJBAFGHna4hY49bpaTGmoG9ZBhGYB7BHfiV3Dd37HA8j3W33ZxTUSUFff5/4
        EKZpQEjittYr/wvfGBcOYq57P
X-Received: by 2002:ac8:546:0:b0:3a9:9218:e110 with SMTP id c6-20020ac80546000000b003a99218e110mr96438696qth.37.1673346472295;
        Tue, 10 Jan 2023 02:27:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtNbXuxMZfi5jwcdohKmvDBprOB9kZdOoqzZtAC3vlZswt2hulAE8XHX60Y529sh9eOWOGAVg==
X-Received: by 2002:ac8:546:0:b0:3a9:9218:e110 with SMTP id c6-20020ac80546000000b003a99218e110mr96438670qth.37.1673346472039;
        Tue, 10 Jan 2023 02:27:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-128.dyn.eolo.it. [146.241.120.128])
        by smtp.gmail.com with ESMTPSA id a19-20020ac81093000000b0039a610a04b1sm5804132qtj.37.2023.01.10.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:27:51 -0800 (PST)
Message-ID: <b87cdb13baab2a02be2fb3ffc54c581d097cbe7d.camel@redhat.com>
Subject: Re: [PATCH net 1/1] net: stmmac: add aux timestamps fifo clearance
 wait
From:   Paolo Abeni <pabeni@redhat.com>
To:     Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Noor Azura Ahmad Tarmizi 
        <noor.azura.ahmad.tarmizi@linux.intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        stable@vger.kernel.org
Date:   Tue, 10 Jan 2023 11:27:47 +0100
In-Reply-To: <20230109151546.26247-1-noor.azura.ahmad.tarmizi@intel.com>
References: <20230109151546.26247-1-noor.azura.ahmad.tarmizi@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-09 at 23:15 +0800, Noor Azura Ahmad Tarmizi wrote:
> Add timeout polling wait for auxiliary timestamps snapshot FIFO clear bit
> (ATSFC) to clear. This is to ensure no residue fifo value is being read
> erroneously.
> 
> Cc: <stable@vger.kernel.org> # 5.10.x
> Signed-off-by: Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>

Please post a new revision of this patch including a suitable 'Fixes'
tag, thanks!

Paolo

