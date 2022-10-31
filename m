Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30607613EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJaUU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJaUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:20:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674D10FF8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:20:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so32321824ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwsZFSIfvDZpHHuxEMGjyPvVY5KuSJvTYvlj6dRm7S4=;
        b=G+7jzDuJE+lROFNuCb0pBK3RV3kM2LDLzDaSS9pSPmGE6aNaSkmYDkxWS3i31Smghh
         VFYCHnMmodCH7Uz4/yE34CRuCmIaiACiuqcCKhpUSOpGDVnasYzdKNI9acrPN82cQhzm
         Ce+NDxVasqi0uD0ILXkfZd72lvEQTNi+yHvxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwsZFSIfvDZpHHuxEMGjyPvVY5KuSJvTYvlj6dRm7S4=;
        b=vzKZUWZfsThbmNA6X6VJUIzGRB3aGTvgbhH876HPr3ClghJmsrFmY78LaJUpfmtqRI
         ygciy5ujN7UynYvGYKPdV7YTBHEWvlMPk6vQp8rPwQusBl/HgYNr01SudpExOG3OBPGe
         GWjgXD85gwxOo2Hf2F7BO6p44XKc/pBWMGEoIH+8JQOrRGykKFX8DkZCQ59uJ1bNFKVs
         yrsAyKCY5l8oXHFtAgnYLl5lxyRDs/rGyP3GBnHO0XM9T0AGRjT2AwCX0f7YMts+epW8
         zs4hdaHxUSCKUN6Fuh9cscrtAEWCeRYfdEmaWZLSh6U+QBi/h4gDhSMqI7zYeCwgE+AE
         +EnA==
X-Gm-Message-State: ACrzQf2YOlRf7LXPEwKM89txphb9vG4OaLURjFGDaYgcGLV/jM7rFyMw
        v0q65HRcQld8MdF0nNYOAru1cAAUPne1nQ==
X-Google-Smtp-Source: AMsMyM6ilnoV1e44wOGFul9K+sdyanPhJ1SEhmpGPvduqkr9A3wPm60yhQvIG5JRrMbZq8q0cQo7TA==
X-Received: by 2002:a17:907:2c6b:b0:7ad:c587:bc5b with SMTP id ib11-20020a1709072c6b00b007adc587bc5bmr9412646ejc.425.1667247649299;
        Mon, 31 Oct 2022 13:20:49 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090676c700b007ad94422cf6sm3347746ejn.198.2022.10.31.13.20.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 13:20:48 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id l11so17890987edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:20:47 -0700 (PDT)
X-Received: by 2002:aa7:d9d1:0:b0:461:9556:23e6 with SMTP id
 v17-20020aa7d9d1000000b00461955623e6mr16135034eds.25.1667247646748; Mon, 31
 Oct 2022 13:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com> <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
 <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2124934d-a8f1-59fa-1958-28472d06d2d6@redhat.com>
In-Reply-To: <2124934d-a8f1-59fa-1958-28472d06d2d6@redhat.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Mon, 31 Oct 2022 16:20:35 -0400
X-Gmail-Original-Message-ID: <CAM7w-FVC3pcjROQA1ra5Py9A9BrQotrwJNiykNSFkUN-p8_DGw@mail.gmail.com>
Message-ID: <CAM7w-FVC3pcjROQA1ra5Py9A9BrQotrwJNiykNSFkUN-p8_DGw@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 4:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Something like this does indeed sound like a nice solution for this.

Agreed, much nicer than letting the monitoring infrastructure hunt for
certain dmesg strings, for sure. Thank you David for the suggestion,
and Mario for the opening ideas.
