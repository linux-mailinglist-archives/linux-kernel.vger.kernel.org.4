Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9D6D1B50
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCaJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjCaJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:06:35 -0400
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 02:06:16 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819021EFE7;
        Fri, 31 Mar 2023 02:06:16 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 7EE05167965;
        Fri, 31 Mar 2023 11:00:45 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680253245; bh=zEsozeK21INXuseg7mdhBkSZOekz6TokRUefkXsXjz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IoSVRKiVReQS++NON+uyP4BaZ2iLq1wCIyQYBM5Hb0KR9orbsQNutAZ/sY/65+NuV
         jQlMehr7/7C9ALI7kLf6AiZjM8a4XGRy6HWQSygZXg2LJOrPQknRAiSMS0mc8/mID3
         Uc5mQePrluCh6kaAt7GedKsHoluPapTGRfhTXsPU0N6UUTf0vn/hYV0+r7j/Q4ninl
         BQCgyVG2fd+pmTJdmQ8dGGnxi4dtRkwmhO9DHMMKtLrDBq8jOFPPodoLUP4XaoIRZ7
         EEbs11xN20P6JYS+C5DZndHLup5OmE3Ye4SXbQDiUj32N8h4i2gRLoufRGpM/pi8Ra
         vNihDFwUg0lnw==
Date:   Fri, 31 Mar 2023 11:00:43 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Juerg Haefliger <juergh@proton.me>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230331110043.7b1ddfa3@meshulam.tesarici.cz>
In-Reply-To: <20230331092553.677e9649@smeagol>
References: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
        <20230331092553.677e9649@smeagol>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juerg,

On Fri, 31 Mar 2023 07:26:09 +0000
Juerg Haefliger <juergh@proton.me> wrote:

> On Tue, 28 Mar 2023 09:54:35 +0200
> Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> 
>[...]
> > Anyway, I suspected that the buffers need not be imported into the vc4
> > driver (also hinted by Eric Anholt in a 2018 blog post [1]), and it
> > seems I was right. I encountered the issue with Ubuntu 22.10; I
> > installed latest openSUSE Tumbleweed yesterday, and I was not able to
> > reproduce the issue there, most likely because the Mesa drivers have
> > been fixed meanwhile. This makes the specific case of the Raspberry Pi 4
> > drivers moot. The issue may still affect other combinations of drivers,
> > but I don't have any other real-world example ATM.  
> 
> I'm only seeing this problem with Wayland, no issue when switching Ubuntu to
> X. It seems Tumbleweed is using X by default.

I know; I was the team lead of SUSE low-level graphics engineers until
end of last year... I have just double-checked, but this output of
wayland-info in the GNOME session accessed over RDP is quite convincing:

interface: 'wl_compositor',                              version:  5, name:  1
interface: 'wl_shm',                                     version:  1, name:  2
        formats (fourcc):
        0x48344258 = 'XB4H'
        0x48344241 = 'AB4H'
        0x48345258 = 'XR4H'
        0x48345241 = 'AR4H'
        0x30334258 = 'XB30'
        0x30334241 = 'AB30'
        0x30335258 = 'XR30'
        0x30335241 = 'AR30'
        0x36314752 = 'RG16'
        0x34324258 = 'XB24'
        0x34324241 = 'AB24'
                 1 = 'XR24'
                 0 = 'AR24'
interface: 'wl_output',                                  version:  3, name:  3
        x: 0, y: 0, scale: 1,
        physical_width: 430 mm, physical_height: 270 mm,
        make: 'FUS', model: 'P20W-5 ECO',
        subpixel_orientation: unknown, output_transform: normal,
        mode:
                width: 1680 px, height: 1050 px, refresh: 59.954 Hz,
                flags: current preferred
interface: 'zxdg_output_manager_v1',                     version:  3, name:  4
        xdg_output_v1
                output: 3
                name: 'HDMI-1'
                description: 'Fujitsu Siemens Computers GmbH 20"'
                logical_x: 0, logical_y: 0
                logical_width: 1680, logical_height: 1050
interface: 'wl_data_device_manager',                     version:  3, name:  5
interface: 'zwp_primary_selection_device_manager_v1',    version:  1, name:  6
interface: 'wl_subcompositor',                           version:  1, name:  7
interface: 'xdg_wm_base',                                version:  4, name:  8
interface: 'gtk_shell1',                                 version:  5, name:  9
interface: 'wp_viewporter',                              version:  1, name: 10
interface: 'zwp_pointer_gestures_v1',                    version:  3, name: 11
interface: 'zwp_tablet_manager_v2',                      version:  1, name: 12
interface: 'wl_seat',                                    version:  8, name: 13
        name: seat0
        capabilities: pointer keyboard
        keyboard repeat rate: 33
        keyboard repeat delay: 500
interface: 'zwp_relative_pointer_manager_v1',            version:  1, name: 14
interface: 'zwp_pointer_constraints_v1',                 version:  1, name: 15
interface: 'zxdg_exporter_v1',                           version:  1, name: 16
interface: 'zxdg_importer_v1',                           version:  1, name: 17
interface: 'zwp_linux_dmabuf_v1',                        version:  3, name: 18
        formats (fourcc) and modifiers (names):
        0x48344258 = 'XB4H'; 0x00ffffffffffffff = INVALID
        0x48344241 = 'AB4H'; 0x00ffffffffffffff = INVALID
        0x36314752 = 'RG16'; 0x00ffffffffffffff = INVALID
        0x30334258 = 'XB30'; 0x00ffffffffffffff = INVALID
        0x30335258 = 'XR30'; 0x00ffffffffffffff = INVALID
        0x30334241 = 'AB30'; 0x00ffffffffffffff = INVALID
        0x30335241 = 'AR30'; 0x00ffffffffffffff = INVALID
        0x34324258 = 'XB24'; 0x00ffffffffffffff = INVALID
        0x34325258 = 'XR24'; 0x00ffffffffffffff = INVALID
        0x34324241 = 'AB24'; 0x00ffffffffffffff = INVALID
        0x34325241 = 'AR24'; 0x00ffffffffffffff = INVALID
interface: 'wp_single_pixel_buffer_manager_v1',          version:  1, name: 19
interface: 'zwp_keyboard_shortcuts_inhibit_manager_v1',  version:  1, name: 20
interface: 'zwp_text_input_manager_v3',                  version:  1, name: 21
interface: 'wp_presentation',                            version:  1, name: 22
        presentation clock id: 1 (CLOCK_MONOTONIC)
interface: 'xdg_activation_v1',                          version:  1, name: 23

Petr T
