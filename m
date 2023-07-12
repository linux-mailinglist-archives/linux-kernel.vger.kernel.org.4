Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B6750B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjGLOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGLOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A489F213A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689172165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
        b=UuFg+m2Yvq/cYBpAgRMODwJ54BqHfYqmezUXh1VJIWgEP0vfhBG1M0pRo81QTilsuArSDw
        W8mdLhVObMlcS1VxSYDBJ10HohWfUJe/NMmNu1iW/HDvI1ejebyhz+z5LaQc6zKYXbXzu/
        HLk7qiwAh7we4NiMCwkxNA8KUHsO9n0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Qb12_jhYNeq7bYtmyBnREg-1; Wed, 12 Jul 2023 10:29:24 -0400
X-MC-Unique: Qb12_jhYNeq7bYtmyBnREg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315af0252c2so358681f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689172163; x=1691764163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
        b=ijlv9oVVO5wkFvyHhjDevIIzcAz8cklX70qxUjITRY3PthsxnVgL9O63L+++RbDw41
         6uz3pxAGMDk3BSpfXrlUQdekFWaNTNJWryJt6Ck99DsXYEPpeHG333ue8r30uCXr5zBr
         r0uljiG61ovUD8/VDq/5dNbmjCuGDwOXl0umnvaUI9hs0ZKjEG64NsQPdYK3RX/8IPbr
         QPZ4Uux3r7YLRzRi3jKEnJZQgYAjKQ0W4dQl4zIiW1AL8fgL6VpT0vEVsOqrWHU7DHF/
         khLTaFsn5NNjTPcZK1nBR9taj1en0873Yd48PrOLrTg5KXHlkazhBh0GOCDV1uqLosC/
         cFZQ==
X-Gm-Message-State: ABy/qLa+X7H2hD2bP08UiwsSLFo8mxRQB/BJyY25DfPRjqAw9c5FouqN
        knnenxAurl3UiDPhV+eukw2f5o8o8osJs+3FpTVdo37woyyXpRrrAPI+VINwZKzIChNnssZLm7M
        x+zalIDAMeYKmZSv6kS8/SGByn9+S8DdO8uf8p1uD
X-Received: by 2002:adf:ec8e:0:b0:314:1ebc:6e19 with SMTP id z14-20020adfec8e000000b003141ebc6e19mr17387199wrn.64.1689172163288;
        Wed, 12 Jul 2023 07:29:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrLy4XTfg4SYrDedL3LjN5ZHr+LA3Ut1XmsVNXLi1zBJheiu9Ajx5OzglpHTo4/1SshVrdO+NlkBUDSAisljg=
X-Received: by 2002:adf:ec8e:0:b0:314:1ebc:6e19 with SMTP id
 z14-20020adfec8e000000b003141ebc6e19mr17387145wrn.64.1689172162850; Wed, 12
 Jul 2023 07:29:22 -0700 (PDT)
MIME-Version: 1.0
From:   Vitaly Grinberg <vgrinber@redhat.com>
Date:   Wed, 12 Jul 2023 17:29:12 +0300
Message-ID: <CACLnSDhA1io1tU0rVvuz6KYx3-c_4zEniLEs3KFUqsvLWATYWw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 08/10] ice: implement dpll interface to control cgu
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     David Airlie <airlied@redhat.com>, andy.ren@getcruise.com,
        anthony.l.nguyen@intel.com, arnd@arndb.de, axboe@kernel.dk,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        claudiajkang@gmail.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, hkallweit1@gmail.com,
        idosch@nvidia.com, intel-wired-lan@lists.osuosl.org,
        jacek.lawrynowicz@linux.intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        jesse.brandeburg@intel.com, Jiri Pirko <jiri@resnulli.us>,
        jonathan.lemon@gmail.com, kuba@kernel.org, kuniyu@amazon.com,
        leon@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux@zary.sk, liuhangbin@gmail.com, lucien.xin@gmail.com,
        masahiroy@kernel.org, michal.michalik@intel.com,
        milena.olech@intel.com, Michal Schmidt <mschmidt@redhat.com>,
        Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, nipun.gupta@amd.com, ogabbay@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc,
        Petr Oros <poros@redhat.com>, razor@blackwall.org,
        ricardo.canuelo@collabora.com, richardcochran@gmail.com,
        saeedm@nvidia.com, sj@kernel.org, tzimmermann@suse.de,
        vadfed@fb.com, vadfed@meta.com, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to clarify about the DPLL phase offset requirement. We can
live without it during the initial submission. The addition of phase
offset can be an increment to patch v10.
Thanks,
Vitaly

